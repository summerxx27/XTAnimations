//
//  UIView.swift
//  XTAnimations
//
//  Created by summerxx on 2023/2/8.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    /// 通过 += 添加视图
    /// - Parameters:
    ///   - parent: 左侧父视图
    ///   - child: 右侧子视图
    @discardableResult
    public static func += (parent: UIView, child: UIView) -> UIView {
        parent.addSubview(child)
        return parent
    }

    /// 通过 += 批量添加视图
    /// - Parameters:
    ///   - parent: 左侧父视图
    ///   - children: 右侧子视图集合
    @discardableResult
    public static func += (parent: UIView, children: [UIView]) -> UIView {
        children.forEach { parent.addSubview($0) }
        return parent
    }
}
