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
                let depthFactor = (centerY + verticalRadius) / (2 * verticalRadius)
                let scale = 0.6 + depthFactor + (1.5 - 0.6)

                // 使用索引来访问和更新元素
                images[index].angle = correctedAngle
                images[index].centerX = centerX
                images[index].centerY = centerY
                images[index].scale = scale
                images[index].rotationY = rotationY

                // 计算正反面显示
                images[index].showFront = rotationY <= 90.0 || rotationY >= 270.0
            }

            images.sort { $0.centerY < $1.centerY }

            self.layoutIfNeeded()
            self.setNeedsDisplay()
        }
    }

    var horizontalRadius: CGFloat = 150.0
    var verticalRadius: CGFloat = 40.0
    var imageCount: Int = 5

    private var images: [ImageParams] = []

    private let imageViewSize: CGSize = CGSize(width: 55, height: 86)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImages()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImages()
    }

    // 初始化图像的位置、旋转、缩放等
    func setupImages() {
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

            // 模拟 3D 缩放效果
            let depthFactor = (centerY + verticalRadius) / (2 * verticalRadius)
            let scale = 0.6 + depthFactor + (1.5 - 0.6)

            var item = ImageParams(index: index, centerX: centerX, centerY: centerY, scale: scale)
            let rotationY = getRotationY(index: index, angle: correctedAngle)
            item.rotationY = CGFloat(ceilf(Float(rotationY)))
            item.angle = correctedAngle
            item.showFront = rotationY <= 90.0 || rotationY >= 270.0
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

            print("draw index: \(item.index), angle: \(item.angle), rotation: \(item.rotationY)")

            let scaledTransform = CATransform3DScale(transform, item.scale, item.scale, 1)
            imageView.layer.transform = scaledTransform

            // 计算 zPosition：根据旋转角度和深度，确保前面的视图有更高的 zPosition
            imageView.layer.zPosition = item.scale * 100

            // 反面/正面切换
            let imageName = item.showFront ? "cardFront" : "cardBack"
            imageView.image = UIImage(named: imageName)

            addSubview(imageView)

            let textL = UILabel().then {
                $0.font = .systemFont(ofSize: 14)
                $0.textColor = UIColor(0x333333)
                $0.text = "\(item.index)"
            }
            textL.frame = CGRect(x: imageX, y: imageY, width: imageViewSize.width, height: imageViewSize.height)
            addSubview(textL)
        }
    }
}

extension LiveRoomLoopEllipticalView {

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
}
