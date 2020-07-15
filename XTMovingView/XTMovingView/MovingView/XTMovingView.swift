//
//  XTMovingView.swift
//  XTMovingView
//
//  Created by summerxx on 2020/7/15.
//  Copyright © 2020 summerxx. All rights reserved.
//

import UIKit

enum MovingDirectionType {
    case left
    case right
}

protocol XTMovingViewProtocol {
    func drawMarqueeView(drawMarqueeView: XTMovingView, animationDidStopFinished: Bool) -> Void
}

class XTMovingView: UIView, CAAnimationDelegate {

    /// 速度
    var speed: Float = 1.0
    /// 宽
    var width: Float = 0.0
    /// 高
    var height: Float = 0.0
    /// 动画视图宽
    var animationViewWidth: Float = 0.0
    /// 动画视图高
    var animationViewHeight: Float = 0.0
    /// 是否停止
    var stop: Bool = true
    /// 方向
    var moveType: MovingDirectionType = .left
    /// 内容
    var contentView = UIView()
    /// 动画视图
    var animationView = UIView()
    /// 协议
    var delegate : XTMovingViewProtocol?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        width = Float(frame.size.width)
        height = Float(frame.size.height)
        speed = 1
        self.layer.masksToBounds = true
        moveType = .left
        animationView = UIView.init(frame: CGRect.init())
        self.addSubview(animationView)
    }
    
    func addContentView(v: UIView) -> Void {
        contentView.removeFromSuperview()
        v.frame = v.bounds
        contentView = v
        animationView.frame = v.bounds
        animationView.addSubview(contentView)
        animationViewWidth = Float(animationView.frame.size.width)
        animationViewHeight = Float(animationView.frame.size.height)
    }
    
    func startAnimation() -> Void {
        animationView.layer.removeAnimation(forKey: "animationViewPosition")
        stop = false
        let pointRightCenter = CGPoint.init(x: Int(width + animationViewWidth / 2), y: Int(animationViewHeight) / 2)
        
        let pointLeftCenter = CGPoint.init(x: -Int(animationViewWidth / 2), y: Int(animationViewHeight) / 2)
        
        let fromPoint  = moveType == .left ? pointRightCenter : pointLeftCenter
        let toPoint = moveType == .left ? pointLeftCenter : pointRightCenter
        
        animationView.center = fromPoint
        
        let movePath = UIBezierPath.init()
        movePath.move(to: fromPoint)
        movePath.addLine(to: toPoint)
        
        let moveAnimation = CAKeyframeAnimation.init(keyPath: "position")
        moveAnimation.path = movePath.cgPath
        moveAnimation.isRemovedOnCompletion = true
        moveAnimation.duration = CFTimeInterval(animationViewWidth / 30 * (1 / speed))
        moveAnimation.delegate = self
        animationView.layer.add(moveAnimation, forKey: "animationViewPosition")
    }
    
    func stopAnimation() -> Void {
        stop = true
        animationView.layer .removeAnimation(forKey: "animationViewPosition")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        delegate?.drawMarqueeView(drawMarqueeView: self, animationDidStopFinished: flag)
        
        if flag && !stop {
            self.startAnimation()
        }
    }
    
    func pauseAnimation() -> Void {
        let layer = animationView.layer
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0
        layer.timeOffset = pausedTime
    }
    
    func resumeAnimation() -> Void {
        let layer = animationView.layer
        let pausedTime = layer.timeOffset
        layer.speed = 1
        layer.timeOffset = 0
        layer.beginTime = 0
        let timeSincePause = layer .convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }

}
