//
//  LiveRoomLoopEllipticalView.swift
//  XTAnimations
//
//  Created by summerxx on 2024/12/7.
//  Copyright © 2024 夏天然后. All rights reserved.
//

import UIKit

class LiveRoomLoopEllipticalView: UIView {

    // 配置参数
    var rotationAngle: CGFloat = 0.0 {
        didSet {
            let pieceAngle = 360.0 / CGFloat(imageCount)
            self.subviews.forEach { v in
                v.removeFromSuperview()
            }
            for (index, item) in images.enumerated() {
                let angle = (rotationAngle + pieceAngle * CGFloat(item.index) + 90).truncatingRemainder(dividingBy: 360)
                // 如果 angle 是负数，我们加上 360 确保结果在 0 到 360 之间, 解决卡片正反面计算不正确的问题
                let correctedAngle = angle < 0 ? angle + 360 : angle

                // 计算图片的位置
                let centerX = horizontalRadius * cos(correctedAngle * .pi / 180)
                let centerY = verticalRadius * sin(correctedAngle * .pi / 180)
                let rotationY = self.getRotationY(index: item.index, angle: correctedAngle)

                // 模拟 3D 缩放效果
                let scale = updateScale(angle: correctedAngle)

                // 使用索引来访问和更新元素
                images[index].angle = correctedAngle
                images[index].centerX = centerX
                images[index].centerY = centerY
                images[index].scale = scale
                images[index].rotationY = rotationY

                // 计算正反面显示
                images[index].showFront = rotationY <= 90.0 || rotationY >= 270.0
                images[index].updateLetter(rotation: rotationY)
            }

            images.sort { $0.centerY < $1.centerY }

            self.layoutIfNeeded()
            self.setNeedsDisplay()
        }
    }

    /// 长半轴
    var horizontalRadius: CGFloat = 150.0
    /// 短半轴
    var verticalRadius: CGFloat = 20.0
    /// 图片个数
    var imageCount: Int = 5
    /// 最后一次的偏移
    var lastTranslation: CGPoint = .zero
    /// 最后一次的弧度
    var lastAngle = 0.0

    /// 定义常量: 用于 scale 的计算
    let selfMax: CGFloat = 1.2
    let selfMiddle: CGFloat = 1.1
    let selfMin: CGFloat = 0.5

    var letter: String = "" // 假设 letter 是类中的一个属性

    private var images: [ImageParams] = []

    private let imageViewSize: CGSize = CGSize(width: 158, height: 211)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        configGusture()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }

    // 初始化图像的位置、旋转、缩放等
    func configUI() {
        let pieceAngle = 360.0 / CGFloat(imageCount)
        self.subviews.forEach { v in
            v.removeFromSuperview()
        }
        images = (0..<imageCount).map { index in
            let angle = (0 + pieceAngle * CGFloat(index) + 90).truncatingRemainder(dividingBy: 360)

            // 如果 angle 是负数，我们加上 360 确保结果在 0 到 360 之间, 解决卡片正反面计算不正确的问题
            let correctedAngle = angle < 0 ? angle + 360 : angle

            // 计算图片的位置
            let centerX = horizontalRadius * cos(correctedAngle * .pi / 180)
            let centerY = verticalRadius * sin(correctedAngle * .pi / 180)

            // 计算缩放
            let scale = updateScale(angle: correctedAngle)

            var item = ImageParams(index: index, centerX: centerX, centerY: centerY, scale: scale)
            let rotationY = getRotationY(index: index, angle: correctedAngle)
            item.rotationY = CGFloat(ceilf(Float(rotationY)))
            item.angle = correctedAngle
            item.showFront = rotationY <= 90.0 || rotationY >= 270.0
            item.updateLetter(rotation: rotationY)
            return item
        }

        images.sort { $0.centerY < $1.centerY }

        self.layoutIfNeeded()
        self.setNeedsDisplay()
    }

    // 绘制图像
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        // 清除所有已经添加的 imageView
        self.subviews.forEach { subview in
            if subview is UIImageView {
                subview.removeFromSuperview()
            }
        }

        // 为每个图像添加 imageView
        for item in images {
            let imageView = UIImageView()

            // 计算图片的位置
            let imageX = item.centerX + bounds.width / 2 - imageViewSize.width / 2
            let imageY = item.centerY + bounds.height / 2 - imageViewSize.height / 2
            imageView.frame = CGRect(x: imageX, y: imageY, width: imageViewSize.width, height: imageViewSize.height)

            // 设置 3D 旋转和缩放
            // 将角度转换为弧度 !!!
            let angle = CGFloat(item.rotationY * Double.pi / 180)
            var transform = CATransform3DIdentity // 初始 Transform
            transform.m34 = -1.0 / 500.0 // 设置透视效果
            transform = CATransform3DRotate(transform, angle, 0, 1, 0) // 绕 Y 轴旋转

            print("draw index: \(item.index), angle: \(item.angle), rotation: \(item.rotationY), centerY: \(item.centerY)")

            let scaledTransform = CATransform3DScale(transform, item.scale, item.scale, 1)
            imageView.layer.transform = scaledTransform

            // 计算 zPosition：根据旋转角度和深度，确保前面的视图有更高的 zPosition
            imageView.layer.zPosition = item.centerY * 100

            // 反面/正面切换
            let imageName = item.showFront ? "cardFront" : "cardBack"
            imageView.image = UIImage(named: imageName)

            addSubview(imageView)

            let textL = UILabel().then {
                $0.font = .systemFont(ofSize: 14)
                $0.textColor = UIColor(0x333333)
                $0.text = "卡片+\(item.letter)"
            }
            textL.frame = CGRect(x: 0, y: 0, width: imageViewSize.width, height: imageViewSize.height)
            imageView.addSubview(textL)
        }
    }
}

extension LiveRoomLoopEllipticalView {

    /// 计算倾斜角: 绕 Y 轴
    func getRotationY(index: Int, angle: CGFloat) -> CGFloat {
        let rotation: CGFloat

        if (18.0...162.0).contains(angle) {
            // Y轴需要从 (18-162) -> (75-(285[-75]))
            var tempRotation = 75.0 - (angle - 18) * (150.0 / 144.0)
            if tempRotation <= 0 {
                tempRotation += 360
            }
            rotation = tempRotation
        } else {
            // Y轴需要从(162-18) -> (285-75)
            let changeAngleTotal = 360.0 + 18.0 - 162.0
            let changeRotationTotal = 285.0 - 75.0

            let currentAngle = angle < 18.0 ? 360.0 + angle : angle

            rotation = 285.0 - ((currentAngle - 162.0) / changeAngleTotal) * changeRotationTotal
        }
//        print("index: \(index), angle: \(angle), rotation: \(rotation)")
        return rotation
    }

    /// 获取缩放数据
    /// - Parameter angle: 卡片在轨道上的角度(0..359)
    /// - Returns: 获取到的 scale
    func updateScale(angle: CGFloat) -> CGFloat {
        // 自身缩放的开始
        let selfStart = selfMiddle

        // 自身缩放的终点
        var selfEnd = selfMiddle

        var angleChangeRadio: CGFloat = 0.0

        switch angle {
        case 0..<90:
            selfEnd = selfMax
            angleChangeRadio = (angle - 0) / 90.0  // 变化总量是90f
        case 90..<180:
            selfEnd = selfMax
            angleChangeRadio = (angle - 180) / 90.0
        case 180..<270:
            selfEnd = selfMin
            angleChangeRadio = (angle - 180) / 90.0
        case 270..<360:
            selfEnd = selfMin
            angleChangeRadio = (angle - 360) / 90.0
        default:
            break
        }

        // 自身的缩放
        let selfScale = selfStart + (selfEnd - selfStart) * abs(angleChangeRadio)

        // 抵抗Y轴自旋带来的视觉高度差
        let resistScale = 0.5 + (1.0 - 0.5) * abs(angleChangeRadio)

        return selfScale * resistScale
    }
}

// 数据结构
struct ImageParams {
    var index: Int = 0
    var centerX: CGFloat
    var centerY: CGFloat
    var scale: CGFloat
    var showFront: Bool = false
    var rotationY: CGFloat = 0.0
    var angle: CGFloat = 0.0
    var letter: String = ""

    mutating func updateLetter(rotation: CGFloat) {
        if rotation >= 0.0 && rotation < 90.0 && letter.isEmpty {
            // 向后取1
            letter = CardResourceManager.shared.acquireBack() ?? ""
        } else if rotation >= 90.0 && rotation < 180.0 && !letter.isEmpty {
            // 向后释放1
            letter = ""
            CardResourceManager.shared.releaseBack()
        } else if rotation > 270.0 && letter.isEmpty {
            // 向前取1
            letter = CardResourceManager.shared.acquireForward() ?? ""
        } else if rotation <= 270.0 && rotation > 180.0 && !letter.isEmpty {
            // 向前释放1
            letter = ""
            CardResourceManager.shared.releaseForward()
        }
    }
}
