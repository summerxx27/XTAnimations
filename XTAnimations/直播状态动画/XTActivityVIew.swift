//
//  XTActivityVIew.swift
//  XTAnimations
//
//  Created by summerxx on 2023/2/8.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit

class ActivityView: UIView {

    /// 动画柱个数
    var numberOfRect = 0;

    /// 动画柱颜色
    var rectBackgroundColor: UIColor?

    /// 动画柱大小
    var rectSize: CGSize?

    /// 动画柱之间的间距
    var space: CGFloat = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        createDefaultAttribute(frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createDefaultAttribute(_ frame: CGRect) -> Void {
        numberOfRect = 6;
        rectBackgroundColor = UIColor.black
        space = 1;
        rectSize = frame.size
    }

    func addAnimateWithDelay(delay: Double) -> CAAnimation {
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.x")
        animation.repeatCount = MAXFLOAT;
        animation.isRemovedOnCompletion = true;
        animation.autoreverses = false;
        animation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.linear)
        animation.fromValue = 0
        animation.toValue = Double.pi
        animation.duration = (Double)(numberOfRect) * 0.2;
        animation.beginTime = CACurrentMediaTime() + delay;
        return animation;
    }

    /// 添加矩形
    func addRect() {
        removeRect()
        isHidden = false
        for  i in 0...numberOfRect - 1 {
            guard let size = rectSize else {
                return
            }
            let x = (CGFloat)(i) * (size.width + space)
            let rView = UIView(frame: CGRect(x: x, y: 0, width: size.width, height: size.height))
            rView.backgroundColor = rectBackgroundColor
            rView.layer.add(addAnimateWithDelay(delay: (Double)(i) * 0.2), forKey: "TBRotate")
            addSubview(rView)
        }
    }

    /// 移除矩形
    func removeRect() {
        if subviews.count > 0 {
            removeFromSuperview()
        }
        isHidden = true
    }

    /// 开始动画
    func startAnimation() {
        addRect()
    }

    /// 结束动画
    func stopAnimation() {
        removeRect()
    }
}

