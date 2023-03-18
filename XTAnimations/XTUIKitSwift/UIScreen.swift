//
//  UIScreen.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/18.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import Foundation
import UIKit

public extension UIScreen {

    /// 屏幕宽度
    static let width = UIScreen.main.bounds.size.width

    /// 屏幕高度
    static let height = UIScreen.main.bounds.size.height

    /// scale
    static let scale = UIScreen.main.scale

    /// 是否是异形屏
    static let isSpecial = (height - BT_HEIGHT_OF_IPHONE_X) >= -1e-5

//    /// 底部安全区
//    static var safeBottom: CGFloat {
//        return UIApplication.window?.safeAreaInsets.bottom ?? 0
//    }
//
//    /// 导航栏高度
//    static var navibarHeight: CGFloat {
//        return UIApplication.statusBarHeight + 44.0
//    }

    /// 底部 tab 高度
    static var tabbarHeight: CGFloat {
        height >= BT_HEIGHT_OF_IPHONE_X ? 83.0 : 49.0
    }

    internal static let BT_HEIGHT_OF_IPHONE_X: CGFloat = 812.0
}

