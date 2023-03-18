//
//  UIColor.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/18.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {

    /// 随机色
    static var randomColor: UIColor {
        get {
            let redValue = CGFloat(Int(arc4random() % 255)) / 255.0
            let blueValue = CGFloat(Int(arc4random() % 255)) / 255.0
            let greenValue = CGFloat(Int(arc4random() % 255)) / 255.0
            return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        }
    }

}
