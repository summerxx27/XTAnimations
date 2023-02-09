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
        view.backgroundColor = .white

        view += [
            activityView,
            animationView
        ]
        
        activityView.snp.makeConstraints {
            $0.left.top.equalTo(110)
            $0.size.equalTo(CGSize(width: 35, height: 15))
        }

        animationView.snp.makeConstraints {
            $0.left.equalTo(110)
            $0.top.equalTo(activityView.snp.bottom).offset(10)
            $0.size.equalTo(CGSize(width: 35, height: 15))
        }

        printPointer(object: animationView)
    }

    private lazy var animationView = LivingView().then {
        $0.animationLayerColor = .red
    }

    lazy var activityView = ActivityView().then {
        $0.numberOfRect = 5
        $0.rectBackgroundColor = UIColor.blue
        $0.space = 1
        $0.rectSize = CGSize(width: 4, height: 15)
        $0.startAnimation()
    }
}
