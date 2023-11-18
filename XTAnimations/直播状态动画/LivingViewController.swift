//
//  LivingViewController.swift
//  XTAnimations
//
//  Created by summerxx on 2023/2/8.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit
import SnapKit

public class LivingViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "ActivityView"
        view.backgroundColor = UIColor.randomColor

        view += [
            activityView,
            animationView,
            progressBar,
            goldCoinCalliperView
        ]
        
        activityView.snp.makeConstraints {
            $0.left.top.equalTo(110)
            $0.size.equalTo(CGSize(width: 7, height: 6))
        }

        animationView.snp.makeConstraints {
            $0.left.equalTo(110)
            $0.top.equalTo(activityView.snp.bottom).offset(10)
            $0.size.equalTo(CGSize(width: 70, height: 70))
        }

        printPointer(object: animationView)

        progressBar.frame = CGRect(0, 400, UIScreen.width, 20)

        goldCoinCalliperView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(-50)
            make.height.equalTo(60)
        }

        RunLoop.main.add(timer, forMode: .common)
        timer.fire()

        // 创建 label
        let label = UILabel(frame: CGRect(x: 50, y: 200, width: 100, height: 50))
        label.text = "Hello, World!"
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .black
        view += label
        // 创建圆角路径
        let cornerRadius: CGFloat = 10
        let path = UIBezierPath(roundedRect: label.bounds, byRoundingCorners: [.bottomRight, .bottomLeft], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))

        // 设置路径填充颜色为 label 的背景颜色
        label.backgroundColor?.setFill()

        // 设置路径描边颜色为 clear
        UIColor.clear.setStroke()

        // 将路径添加到 label 的 layer 上
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        label.layer.mask = maskLayer


        let string = "Hello, world!"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 20),
            .foregroundColor: UIColor.black,
            .strokeWidth: -2.0,
            .strokeColor: UIColor.red,
        ]

        let attributedString = NSAttributedString(string: string, attributes: attributes)
        label.attributedText = attributedString
    }

    private lazy var timer = Timer(timeInterval: 0.5,
                                   target: self,
                                   selector: #selector(start),
                                   userInfo: nil,
                                   repeats: true)

    private lazy var animationView = LivingView().then {
        $0.backgroundColor = .red
    }

    lazy var activityView = ActivityView().then {
        $0.numberOfRect = 3
        $0.backgroundColor = .red
        $0.rectBackgroundColor = UIColor.blue
        $0.space = 1
        $0.rectSize = CGSize(width: 1.7, height: 6)
        $0.startAnimation()
    }

    lazy var progressBar = PKProgressBar().then {
        $0.backgroundColor = .cyan
    }

    lazy var goldCoinCalliperView = GoldCoinCalliperView()
}

extension LivingViewController {

    @objc func start() {
        let left = Int(arc4random()) % (100 - 1 + 1) + 1
        progressBar.updateProgress(left: CGFloat(left) / 100.0)
    }
}
