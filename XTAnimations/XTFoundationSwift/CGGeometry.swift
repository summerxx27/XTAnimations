//
//  CGGeometry.swift
//  XTAnimations
//
//  Created by summerxx on 2023/2/8.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import Foundation
import UIKit

///
/// 对 CGSize, CGRect, CGPoint, UIEdgeInsets 进行一些美化, 和便利的调用方式
///

/// 最大的 CGFloat
public let CGFloatMax = CGFloat(MAXFLOAT)

extension CGSize {

    /// 未命名参数的初始化
    public init(_ width: CGFloat, _ height: CGFloat) {
        self.init()
        self.width = width
        self.height = height
    }

    /// 生成一个正方形 CGSize
    public static func square(_ length: CGFloat) -> CGSize {
        CGSize(width: length, height: length)
    }

    /// 向上取整
    public var ceiling: CGSize {
        CGSize(width: Darwin.ceil(width), height: Darwin.ceil(height))
    }

    /// 四舍五入取整
    public var rounding: CGSize {
        CGSize(width: Darwin.round(width), height: Darwin.round(height))
    }

    /// 与 `size` 的 x 轴中点位置
    public func centerX(_ size: CGSize) -> CGFloat {
        (self.width - size.width) * 0.5
    }

    /// 与 `width` 的 x 轴中点位置
    public func centerX(_ width: CGFloat) -> CGFloat {
        (self.width - width) * 0.5
    }

    /// 与 `size` 的 y 轴中点位置
    public func centerY(_ size: CGSize) -> CGFloat {
        (self.height - size.height) * 0.5
    }

    /// 与 `height` 的 y 轴中点位置
    public func centerY(_ height: CGFloat) -> CGFloat {
        (self.height - height) * 0.5
    }
}

extension CGRect {

    /// 未命名参数的初始化
    public init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self.init()
        self.origin = CGPoint(x: x, y: y)
        self.size = CGSize(width: width, height: height)
    }

    /// 未命名参数的初始化
    public init(_ x: CGFloat, _ y: CGFloat, _ size: CGSize) {
        self.init()
        self.origin = CGPoint(x: x, y: y)
        self.size = size
    }

    /// 未命名参数的初始化
    public init(_ origin: CGPoint, _ size: CGSize) {
        self.init()
        self.origin = origin
        self.size = size
    }

    /// 向上取整
    public var ceiling: CGRect {
        CGRect(x: ceil(origin.x), y: ceil(origin.y), width: ceil(size.width), height: ceil(size.height))
    }

    /// 顶部
    public var top: CGFloat {
        get { origin.y }
        set { origin.y = newValue }
    }

    /// 底部
    public var bottom: CGFloat {
        get { origin.y + size.height }
        set { origin.y = newValue - size.height }
    }

    /// 左侧
    public var left: CGFloat {
        get { origin.x }
        set { origin.x = newValue }
    }

    /// 右侧
    public var right: CGFloat {
        get { origin.x + size.width }
        set { origin.x = newValue - size.width }
    }

    /// `size` 相对于当前 rect 的中心位置
    public func centerPoint(_ size: CGSize) -> CGPoint {
        CGPoint((width - size.width) * 0.5, (height - size.height) * 0.5)
    }

    /// 将 `size` 放在当前 rect 中心位置时的 rect
    public func centerRect(_ size: CGSize) -> CGRect {
        CGRect(centerPoint(size), size)
    }
}

extension CGPoint {

    /// 未命名参数的初始化
    public init(_ x: CGFloat, _ y: CGFloat) {
        self.init()
        self.x = x
        self.y = y
    }

    /// 向上取整
    public var ceiling: CGPoint {
        CGPoint(x: ceil(x), y: ceil(y))
    }
}

extension UIEdgeInsets {

    /// 只初始化指定的边距，其他默认为 0
    public static func only(top: CGFloat = 0,
                            left: CGFloat = 0,
                            bottom: CGFloat = 0,
                            right: CGFloat = 0) -> UIEdgeInsets {
        UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    /// 设置 TLBR 四个边距
    public static func all(_ inset: CGFloat) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    /// 向上取整
    public var ceiling: UIEdgeInsets {
        UIEdgeInsets(top: ceil(top), left: ceil(left), bottom: ceil(bottom), right: ceil(right))
    }
}
