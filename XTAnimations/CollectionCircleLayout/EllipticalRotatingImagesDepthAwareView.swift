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
    var verticalRadius: CGFloat = 40.0
    var imageCount: Int = 6

    private var images: [ImageParams] = []

    private let imageViewSize: CGFloat = 80.0

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

            // 计算图片的位置
            let centerX = horizontalRadius * cos(angle * .pi / 180)
            let centerY = verticalRadius * sin(angle * .pi / 180)

            // 模拟 3D 缩放效果
            let scale = 0.8 + (1.2 - 0.8) * (1 + centerY * 2 / verticalRadius) / 2

            var item = ImageParams(centerX: centerX, centerY: centerY, scale: scale)
            item.updateAngle(angle: angle)
            return item
        }

        images.sort { $0.centerY < $1.centerY } // 按 centerY 排序

        self.layoutIfNeeded()
        self.setNeedsDisplay()
    }

    // 每帧动画更新 rotationAngle
    func startRotationAnimation() {
        let duration: TimeInterval = 15.0
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = 2 * CGFloat.pi
        animation.duration = duration
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "rotationAnimation")
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

        for item in images {
            let imageView = UIImageView()
            imageView.frame = CGRect(x:item.centerX + bounds.width / 2 - imageViewSize / 2, y: item.centerY + bounds.height / 2 - imageViewSize / 2, width: imageViewSize, height: imageViewSize)
            imageView.backgroundColor = .randomColor
            // 设置 3D 旋转和缩放

            let angle = CGFloat(-item.rotation * Double.pi / 180) // 将 30 度转换为弧度
            var transform = CATransform3DIdentity // 初始 Transform
            transform = CATransform3DRotate(transform, angle, 0, 1, 0) // 绕 Y 轴旋转
            let scaledTransform = CATransform3DScale(transform, item.scale, item.scale, 1)
            imageView.layer.transform = scaledTransform

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

    mutating func updateAngle(angle: CGFloat) {
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
