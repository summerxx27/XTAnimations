//
//  PageSubViewController.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/28.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit
import SnapKit

class PageSubViewController: UIViewController {

    var testVC = TestViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(testVC)
        testVC.view.frame = CGRect(0, 200, UIScreen.width, 200)
        view.addSubview(testVC.view)
    }
}


