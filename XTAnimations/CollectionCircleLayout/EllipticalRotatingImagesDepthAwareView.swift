//
//  EllipticalRotatingImagesDepthAwareView.swift
//  XTAnimations
//
//  Created by summerxx on 2024/12/7.
//  Copyright © 2024 夏天然后. All rights reserved.
//

import UIKit

class EllipticalRotatingImagesDepthAwareView: UIView {

    // 配置参数
    var rotationAngle: CGFloat = 0.0 {
        didSet {
            setupImages()
        }
    }

    var horizontalRadius: CGFloat = 150.0
    var verticalRadius: CGFloat = 20.0
    var imageCount: Int = 5

    private var images: [ImageParams] = []

    private let imageViewSize: CGSize = CGSize(width: 110, height: 173)

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
            let angle = (rotationAngle + pieceAngle * CGFloat(index) + 90).truncatingRemainder(dividingBy: 360)

            // 如果 angle 是负数，我们加上 360 确保结果在 0 到 360 之间, 解决卡片正反面计算不正确的问题
            let correctedAngle = angle < 0 ? angle + 360 : angle

            // 计算图片的位置
            let centerX = horizontalRadius * cos(correctedAngle * .pi / 180)
            let centerY = verticalRadius * sin(correctedAngle * .pi / 180)

            // 模拟 3D 缩放效果
            let scale = 0.8 + (1.2 - 0.8) * (1 + centerY * 2 / verticalRadius) / 2

            var item = ImageParams(centerX: centerX, centerY: centerY, scale: scale)
            item.updateAngle(angle: correctedAngle)
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
            let angle = CGFloat(-item.rotation * Double.pi / 180) // 将角度转换为弧度
            var transform = CATransform3DIdentity // 初始 Transform
            transform.m34 = -1.0 / 500.0 // 设置透视效果
            transform = CATransform3DRotate(transform, angle, 0, 1, 0) // 绕 Y 轴旋转
            let scaledTransform = CATransform3DScale(transform, item.scale, item.scale, 1)
            imageView.layer.transform = scaledTransform

            // 计算 zPosition：根据角度调整 zPosition
            let normalizedAngle = item.angle.truncatingRemainder(dividingBy: 360) // 确保角度在 0 到 360 之间
            let zPositionFactor = cos(CGFloat(normalizedAngle) * .pi / 180) // 根据角度计算 zPosition 的值
            imageView.layer.zPosition = CGFloat(item.index) * 10 + (zPositionFactor * 100) // 可以调整比例因子（100）以获得合适的视觉效果


            // 反面/正面切换
            let imageName = item.showFront ? "cardFront" : "cardBack" // 用你的图片替代
            imageView.image = UIImage(named: imageName)

            addSubview(imageView)
        }
    }
}

// 数据结构
struct ImageParams {
    var index: Int = 0
    var centerX: CGFloat
    var centerY: CGFloat
    var scale: CGFloat
    var showFront: Bool = false
    var rotation: CGFloat = 0.0
    var angle: CGFloat = 0.0

    mutating func updateAngle(angle: CGFloat) {
        self.angle = angle
        if (30...150).contains(angle) {
            showFront = true
            rotation = (angle - 30) * 180 / 120 + 90
        } else {
            let transformAngle = angle < 30 ? 360 + angle : angle
            let temp = Int(270.0 + (transformAngle - 150.0) * 180.0 / 240.0)
            rotation = CGFloat(temp % 360)
            showFront = false
        }
    }
}
