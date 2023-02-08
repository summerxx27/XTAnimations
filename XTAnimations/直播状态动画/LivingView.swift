//
//  XTLivingView.swift
//  XTAnimations
//
//  Created by summerxx on 2023/2/8.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit

class LivingView: UIView {

    public var animationLayerColor = UIColor.white {
        didSet {
            startAnimation()
        }
    }

    public override class var layerClass: AnyClass {
        CAReplicatorLayer.self
    }

    private var replicatorLayer: CAReplicatorLayer {
        guard let replicatorLayer = self.layer as? CAReplicatorLayer  else {
            fatalError("Layer Error. Check DJLiveIngAnimationView.layerClass")
        }
        return replicatorLayer
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        startAnimation()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override func awakeFromNib() {
        super.awakeFromNib()

        startAnimation()
    }

    private func startAnimation() {
        let width = 4.px
        let height = 20.px
        let animationLayer = CALayer()
        animationLayer.bounds = CGRect(origin: .zero, size: CGSize(width: width, height: height))
        animationLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
        animationLayer.position = CGPoint(x: width * 0.5, y: height)
        animationLayer.cornerRadius = 1.0
        animationLayer.backgroundColor = animationLayerColor.cgColor
        replicatorLayer.addSublayer(animationLayer)

        let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")
        animation.duration = 1
        animation.values = [0.2, 0.9, 0.2]
        animation.autoreverses = true
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = false
        animationLayer.add(animation, forKey: nil)

        replicatorLayer.instanceCount = 3
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(8.px, 0, 0)
        replicatorLayer.instanceDelay = 0.2
    }
}
