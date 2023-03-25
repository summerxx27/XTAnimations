//
//  UIFont.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/25.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit

public extension UIFont {

    // MARK: 阿语字体

    // MARK: 英语字体

    // MARK: 设计字体
    @available(iOS 9, *) convenience init?(ubuntu weight: UIFont.Weight, size: CGFloat) {
        // 新增设计字体方法，具体字体尚未确定，先用系统字体替代
        var fontName: String
        switch weight {
        case .regular:      fontName = "PingFangSC-Regular"; break
        case .semibold:     fontName = "PingFangSC-Semibold"; break
        case .thin:         fontName = "PingFangSC-Thin"; break
        case .light:        fontName = "PingFangSC-Light"; break
        case .medium:       fontName = "PingFangSC-Medium"; break
        case .bold:         fontName = "PingFangSC-Medium"; break
        case .heavy:        fontName = "PingFangSC-Medium"; break
        case .black:        fontName = "PingFangSC-Medium"; break
        case .ultraLight:   fontName = "PingFangSC-UltraLight"; break
        default:            fontName = "PingFangSC-Regular"; break
        }
        self.init(name: fontName, size: size)
    }
}

extension UIFont {
    // MARK: 设计字体
    public static func ubuntu(_ weight: UIFont.Weight, pixels: CGFloat) -> UIFont {
        UIFont.init(ubuntu: weight, size: pixels) ?? UIFont.systemFont(ofSize: pixels)
    }
}
