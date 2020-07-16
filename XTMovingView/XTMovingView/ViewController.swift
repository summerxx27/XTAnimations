//
//  ViewController.swift
//  XTMovingView
//
//  Created by summerxx on 2020/7/15.
//  Copyright © 2020 summerxx. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XTMovingViewProtocol {
    
    var drawMarqueeView0 = XTMovingView()
    var drawMarqueeView1 = XTMovingView()
    var drawMarqueeView2 = XTMovingView()
    var drawMarqueeView3 = XTMovingView()
    var drawMarqueeView4 = XTMovingView()
    var drawMarqueeView5 = XTMovingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenWidth = self.view.frame.size.width
        drawMarqueeView0 = XTMovingView.init(frame: CGRect.init(x: 0, y: 104, width: screenWidth, height: 20.0))
        drawMarqueeView0.delegate = self
        drawMarqueeView0.speed = 1
        drawMarqueeView0.backgroundColor = UIColor.clear
        drawMarqueeView0.moveType = .right
        drawMarqueeView0.speedType = .normal
        self.view.addSubview(drawMarqueeView0)
        drawMarqueeView0.addContentView(v: self.createLabelWithText(text: "夏天然后😁", color: UIColor.black))
        drawMarqueeView0.startAnimation()
        
        drawMarqueeView1 = XTMovingView.init(frame: CGRect.init(x: 0, y: 124, width: screenWidth, height: 20.0))
        drawMarqueeView1.delegate = self
        drawMarqueeView1.speed = 2
        drawMarqueeView1.backgroundColor = UIColor.clear
        drawMarqueeView1.moveType = .left
        self.view.addSubview(drawMarqueeView1)
        drawMarqueeView1.addContentView(v: self.createLabelWithText(text: "夏天然后😁", color: UIColor.black))
        drawMarqueeView1.startAnimation()
        
        drawMarqueeView2 = XTMovingView.init(frame: CGRect.init(x: 0, y: 144, width: screenWidth, height: 20.0))
        drawMarqueeView2.delegate = self
        drawMarqueeView2.speed = 3
        drawMarqueeView2.backgroundColor = UIColor.clear
        drawMarqueeView2.moveType = .right
        self.view.addSubview(drawMarqueeView2)
        drawMarqueeView2.addContentView(v: self.createLabelWithText(text: "夏天然后😁", color: UIColor.black))
        drawMarqueeView2.startAnimation()
        
        drawMarqueeView3 = XTMovingView.init(frame: CGRect.init(x: 0, y: 164, width: screenWidth, height: 20.0))
        drawMarqueeView3.delegate = self
        drawMarqueeView3.speed = 2
        drawMarqueeView3.backgroundColor = UIColor.clear
        drawMarqueeView3.moveType = .left
        self.view.addSubview(drawMarqueeView3)
        drawMarqueeView3.addContentView(v: self.createLabelWithText(text: "夏天然后😁", color: UIColor.black))
        drawMarqueeView3.startAnimation()
        /// 4.
        drawMarqueeView4 = XTMovingView.init(frame: CGRect.init(x: 0, y: 324, width: screenWidth / 2, height: 400))
        drawMarqueeView4.delegate = self
        drawMarqueeView4.speed = 2
        drawMarqueeView4.backgroundColor = UIColor.purple
        drawMarqueeView4.moveType = .bottom
        self.view.addSubview(drawMarqueeView4)
        drawMarqueeView4.addContentView(v: self.createLabelWithText(text: "夏天然后😁", color: UIColor.black))
        drawMarqueeView4.startAnimation()
        
        /// 5.
        drawMarqueeView5 = XTMovingView.init(frame: CGRect.init(x: screenWidth / 2, y: 324, width: screenWidth / 2, height: 400))
        drawMarqueeView5.delegate = self
        drawMarqueeView5.speed = 2
        drawMarqueeView5.backgroundColor = UIColor.purple
        drawMarqueeView5.moveType = .top
        self.view.addSubview(drawMarqueeView5)
        drawMarqueeView5.addContentView(v: self.createLabelWithText(text: "夏天然后😁", color: UIColor.black))
        drawMarqueeView5.startAnimation()
        /// 布局Button
        self.setupButton()
    }
    
    /// 创建AmationView的子视图, 这里我放置的是Label
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
    
    /// 标题字符串
    func randomString() -> NSString {
        let array = ["🤗", "我的博客: summerxx.com☺️"]
        return array[Int(arc4random()) % array.count] as NSString
    }
    
    /// 代理方法
    func drawMarqueeView(drawMarqueeView: XTMovingView, animationDidStopFinished: Bool) {
        drawMarqueeView.stopAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            drawMarqueeView.addContentView(v: self.createLabelWithText(text: self.randomString(), color: UIColor.black))
            
            drawMarqueeView.startAnimation()
        }
    }
    
    /// 停止
    @objc func pause() -> Void {
        drawMarqueeView0.pauseAnimation()
        drawMarqueeView1.pauseAnimation()
        drawMarqueeView2.pauseAnimation()
        drawMarqueeView3.pauseAnimation()
        drawMarqueeView4.pauseAnimation()
        drawMarqueeView5.pauseAnimation()

    }
    
    /// 重启
    @objc func resume() -> Void {
        drawMarqueeView0.resumeAnimation()
        drawMarqueeView1.resumeAnimation()
        drawMarqueeView2.resumeAnimation()
        drawMarqueeView3.resumeAnimation()
        drawMarqueeView4.resumeAnimation()
        drawMarqueeView5.resumeAnimation()

    }
    
    /// 布局按钮
    func setupButton() -> Void {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect.init(x: 0, y: drawMarqueeView3.frame.maxY + drawMarqueeView0.frame.size.height, width: 100, height: 100)
        button.backgroundColor = UIColor.cyan
        button.setTitle("pause", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(pause), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
        
        let resumeButton = UIButton.init(type: UIButton.ButtonType.custom)
        resumeButton.frame = CGRect.init(x: 100, y: button.frame.minY, width: 100, height: 100)
        resumeButton.backgroundColor = UIColor.yellow
        resumeButton.setTitle("resume", for: UIControl.State.normal)
        resumeButton.addTarget(self, action: #selector(resume), for: UIControl.Event.touchUpInside)
        self.view.addSubview(resumeButton)
    }
}

