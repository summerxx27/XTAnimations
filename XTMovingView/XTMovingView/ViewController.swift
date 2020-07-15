//
//  ViewController.swift
//  XTMovingView
//
//  Created by summerxx on 2020/7/15.
//  Copyright © 2020 summerxx. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XTMovingViewProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let drawMarqueeView0 = XTMovingView.init(frame: CGRect.init(x: 0, y: 104, width: self.view.frame.size.width, height: 20.0))
        drawMarqueeView0.delegate = self
        drawMarqueeView0.speed = 1
        drawMarqueeView0.backgroundColor = UIColor.yellow
        drawMarqueeView0.moveType = .left
        self.view.addSubview(drawMarqueeView0)
        drawMarqueeView0.addContentView(v: self.createLabelWithText(text: "夏天然后", color: UIColor.black))
        drawMarqueeView0.startAnimation()
    }

    func createLabelWithText(text: NSString, color: UIColor) -> UILabel {
        let font:UIFont! = UIFont.systemFont(ofSize: 12)
        let attributes = [NSAttributedString.Key.font:font]
        let str = text
        let w = str.calculateWidthWithAttributeText(dic: attributes as Dictionary<NSAttributedString.Key, Any>)
        let label = UILabel.init(frame: CGRect.init(x: 0.0, y: 0.0, width: Double(w), height: 20.0))
        label.font = font
        label.text = text as String
        label.textColor = color
        label.backgroundColor = UIColor.green
        label.sizeToFit()
        return label
    }
    
    func randomString() -> NSString {
        let array = ["夏天是个大人了", "summerxx.com"]
        return array[Int(arc4random()) % array.count] as NSString
    }
    
    func drawMarqueeView(drawMarqueeView: XTMovingView, animationDidStopFinished: Bool) {
        drawMarqueeView.stopAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            drawMarqueeView.addContentView(v: self.createLabelWithText(text: self.randomString(), color: UIColor.black))
            
            drawMarqueeView.startAnimation()
        }
    }

}

