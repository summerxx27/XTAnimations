//
//  RunningViewController.swift
//  XTAnimations
//
//  Created by summerxx on 2023/2/9.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit

class RunningViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "running text"
        view += label
        label.snp.makeConstraints {
            $0.left.equalTo(50)
            $0.top.equalTo(200)
        }
        // 开始动画
        startAnimation()
    }

    lazy var label = UILabel().then {
        $0.text = "This is a running text."
    }



    func startAnimation() {
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat, .curveLinear], animations: {
            self.label.center.x = self.view.bounds.width - self.label.bounds.width / 2
        }, completion: nil)
    }

}

