//
//  XTCircleCollectionViewTestVC.swift
//  XTAnimations
//
//  Created by summerxx on 2024/12/5.
//  Copyright © 2024 夏天然后. All rights reserved.
//
import UIKit

class XTCircleCollectionViewTestVC: UIViewController {

    private var lastTranslation: CGPoint = .zero

    var lastAngle = 0.0

    var awareView = EllipticalRotatingImagesDepthAwareView()

    override func viewDidLoad() {
        super.viewDidLoad()


        self.view += awareView
        awareView.backgroundColor = .cyan
        awareView.frame = CGRect(x: 0, y: 200, width: UIScreen.width, height: 400)

        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panAction))
        awareView.addGestureRecognizer(pan)


        let testView = UIView()
        view += testView
        testView.frame = CGRect(0, 700, 100, 100)
        testView.backgroundColor = .yellow

        let angle = CGFloat(30 * Double.pi / 180) // 将 30 度转换为弧度
        var transform = CATransform3DIdentity // 初始 Transform
        transform.m34 = -1.0 / 500.0 // 设置透视效果
        transform = CATransform3DRotate(transform, angle, 0, 1, 0) // 绕 Y 轴旋转
        testView.layer.transform = transform
    }


    @objc func panAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.awareView)

        // 获取拖动的增量
        let deltaX = translation.x - lastTranslation.x
        let newX = deltaX / 10 + lastAngle

        if newX > 360 {
            lastAngle = newX - 360
        } else if newX < 0 {
            lastAngle = 360 + newX
        } else {
            lastAngle = newX
        }
        awareView.rotationAngle = -lastAngle
    }
}
