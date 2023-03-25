//
//  UIColor.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/18.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import Foundation
import UIKit

extension Int {

    /// 转成 CGFloat 类型
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}

/// 色值 - RGB
public typealias ColorRGB = Int

public extension UIColor {
    class func hex(_ hex: String, _ alpha: Double = 1) -> UIColor {

        var cStr : String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if cStr.hasPrefix("#") {
            cStr = String(cStr.suffix(from: cStr.index(after: cStr.startIndex)))
        }
        if cStr.count != 6 {
            return UIColor.white
        }

        let rStr = String(cStr[cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)])
        let gStr = String(cStr[cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)])
        let bStr = String(cStr[cStr.index(cStr.endIndex, offsetBy: -2)...])

        var r: UInt64 = 0, g: UInt64 = 0, b: UInt64 = 0;
        Scanner(string: rStr).scanHexInt64(&r)
        Scanner(string: gStr).scanHexInt64(&g)
        Scanner(string: bStr).scanHexInt64(&b)

        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
    }
}

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

    /// 16进制数组转 UIColor
    /// eg.
    ///    UIColor(0x333333)
    /// - Parameters:
    ///   - hex: 16进制数
    ///   - alpha: 透明度
    convenience init(_ hex: ColorRGB, alpha: CGFloat = 1.0) {
        self.init(
            red: ((hex >> 16) & 0xff).cgFloat / 255.0,
            green: ((hex >> 8) & 0xff).cgFloat / 255.0,
            blue: (hex & 0xff).cgFloat / 255.0,
            alpha: alpha
        )
    }

    /// 颜色字符串串转 UIColor，错误格式返回白色
    /// eg.
    ///    UIColor("#333333")、UIColor("333333")
    /// - Parameters:
    ///   - hex: 十六进制字符串
    ///   - alpha: 透明度，默认值 1
    /// - Returns: 转换后的 UIColor
    convenience init(_ hex: String, _ alpha: Double = 1) {
        var cStr : String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if cStr.hasPrefix("#") {
            cStr = String(cStr.suffix(from: cStr.index(after: cStr.startIndex)))
        }
        if cStr.count != 6 {
            self.init(white: 1, alpha: 1)
        } else {
            let rStr = String(cStr[cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)])
            let gStr = String(cStr[cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)])
            let bStr = String(cStr[cStr.index(cStr.endIndex, offsetBy: -2)...])

            var r: UInt64 = 0, g: UInt64 = 0, b: UInt64 = 0;
            Scanner(string: rStr).scanHexInt64(&r)
            Scanner(string: gStr).scanHexInt64(&g)
            Scanner(string: bStr).scanHexInt64(&b)

            self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
        }
    }
}

public extension CGColor {

    /// CGColor 转 UIColor.
    var uiColor: UIColor? {
        return UIColor(cgColor: self)
    }
}

