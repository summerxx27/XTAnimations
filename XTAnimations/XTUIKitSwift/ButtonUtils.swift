//
//  ButtonUntils.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/27.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import Foundation

class ButtonUtils {
    // 将按钮标题和图片的位置调整为水平居中
    static func centerAlign(button: UIButton, spacing: CGFloat) {
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center

        let imageSize = button.imageView?.frame.size ?? CGSize.zero
        let titleSize = button.titleLabel?.frame.size ?? CGSize.zero
        let totalHeight = imageSize.height + titleSize.height + spacing
        let totalWidth = max(imageSize.width, titleSize.width)

        button.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: (totalWidth - imageSize.width) / 2.0,
            bottom: 0,
            right: 0)

        button.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -(totalWidth - titleSize.width) / 2.0,
            bottom: -(totalHeight - titleSize.height),
            right: 0)
    }

    // 将按钮标题和图片的位置调整为垂直居中
    static func middleAlign(button: UIButton, spacing: CGFloat) {
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center

        let imageSize = button.imageView?.frame.size ?? CGSize.zero
        let titleSize = button.titleLabel?.frame.size ?? CGSize.zero
        let totalWidth = max(imageSize.width, titleSize.width)
        let totalHeight = imageSize.height + titleSize.height + spacing

        button.imageEdgeInsets = UIEdgeInsets(
            top: (button.frame.size.height - totalHeight) / 2.0,
            left: (button.frame.size.width - imageSize.width) / 2.0,
            bottom: 0,
            right: 0)

        button.titleEdgeInsets = UIEdgeInsets(
            top: imageSize.height + spacing + (button.frame.size.height - totalHeight) / 2.0,
            left: -(totalWidth - titleSize.width) / 2.0,
            bottom: 0,
            right: 0)
    }
}
