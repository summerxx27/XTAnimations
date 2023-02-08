//
//  UIView.swift
//  XTAnimations
//
//  Created by summerxx on 2023/2/8.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 视图的一些便捷方法
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

    /// 对当前视图截图，返回 UIImage 对象
    @objc
    public func toUIImage(scale: CGFloat = 0) -> UIImage {
        let render = UIGraphicsImageRenderer(size: bounds.size)
        return render.image { context in
            layer.render(in: context.cgContext)
        }
    }

    /// 对当前视图截图，返回 UIImage 对象
    @objc
    @available(swift, obsoleted: 1.0)
    public func toUIImage() -> UIImage? {
        toUIImage(scale: 0)
    }

    /// 克隆当前视图
    @objc
    public func cloned() -> UIView? {
        NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as? UIView
    }
}

// MARK: - 安全区
extension UIView {

    /// 视图当前安全区的 left
    @objc
    public var safeAreaLeft: CGFloat { xt_safeAreaInsets.left }

    /// 视图当前安全区的 right
    @objc
    public var safeAreaRight: CGFloat { xt_safeAreaInsets.right }

    /// 视图当前安全区的 top
    @objc
    public var safeAreaTop: CGFloat { xt_safeAreaInsets.top }

    /// 视图当前安全区的 bottom
    @objc
    public var safeAreaBottom: CGFloat { xt_safeAreaInsets.bottom }

    private var xt_safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return safeAreaInsets
        }
        return .zero
    }
}

// MARK: - 遮罩
extension UIView {

    /// 生成圆形遮罩
    @objc
    public func makeCircleMask() {
        makeMask(size: bounds.size)
    }

    /// 生成特定大小及任意角的遮罩
    /// - Parameters:
    ///   - size: 遮罩大小
    ///   - corner: 边角类型
    ///   let maskSize = CGSize(3, 3)
    ///   view.makeMask(size: maskSize, corner: .allCorners)
    @objc
    public func makeMask(size: CGSize, corner: UIRectCorner = .allCorners) {
        layer.mask = CAShapeLayer().then {
            $0.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corner, cornerRadii: size).cgPath
            $0.frame = bounds
        }
    }

    /// 生成特定大小的遮罩
    /// - Parameter size: 遮罩大小
    @objc
    @available(swift, obsoleted: 1.0)
    public func makeMask(size: CGSize) {
        makeMask(size: size, corner: .allCorners)
    }
}

extension UIView {
    /// 设置圆角
    ///
    /// 该方法依赖视图的大小，当视图大小改变后，需要重新调用该方法
    ///
    /// - Parameters:
    ///   - corners: 需要设定的角
    ///   - radius: 圆角半径
    public func setRoundingCorners(_ corners: UIRectCorner, radius: CGFloat) {
        layer.mask = CAShapeLayer().then {
            $0.frame = bounds
            $0.path = UIBezierPath(roundedRect: bounds,
                                   byRoundingCorners: corners,
                                   cornerRadii: CGSize(radius, radius)).cgPath
        }
    }
}

// MARK: - 动画
extension UIView {
    /// 运行弹簧动画
    public class func runSpringAnimate(withDuration duration: TimeInterval,
                                       animations: @escaping () -> Void,
                                       completion: ((Bool) -> Void)? = nil) {
        animate(withDuration: duration,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0,
                options: [],
                animations: animations,
                completion: completion)
    }
}

