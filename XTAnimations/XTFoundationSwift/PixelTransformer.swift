//
//  PixelTransformer.swift
//  XTAnimations
//
//  Created by summerxx on 2023/2/8.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import Foundation
import UIKit

public extension Float {
    /// 像素值转 point 值
    var px: CGFloat {
        kAdapt(CGFloat(self))
    }
}

public extension Double {
    /// 像素值转 point 值
    var px: CGFloat {
        kAdapt(CGFloat(self))
    }
}

public extension Int {
    /// 像素值转 point 值
    var px: CGFloat {
        kAdapt(CGFloat(self))
    }
}

public extension CGFloat {
    /// 像素值转 point 值
    var px: CGFloat {
        kAdapt(self)
    }
}

public extension CGSize {
    /// 像素值转 point 值
    var px: CGSize {
        CGSize(width: width.px, height: height.px)
    }
}

public extension CGRect {
    /// 像素值转 point 值
    var px: CGRect {
        CGRect(x: origin.x.px, y: origin.y.px, width: size.width.px, height: size.height.px)
    }
}

public extension UIEdgeInsets {
    /// 像素值转 point 值
    var px: UIEdgeInsets {
        UIEdgeInsets(top: top.px, left: left.px, bottom: bottom.px, right: right.px)
    }
}

// MARK: -

private func kAdapt(_ x: CGFloat) -> CGFloat {
    x * kScreenWidth * 1.0 / 750.0
}

private let kScreenWidth = UIScreen.main.bounds.size.width
