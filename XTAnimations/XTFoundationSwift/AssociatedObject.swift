//
//  AssociatedObject.swift
//  XTAnimations
//
//  Created by summerxx on 2023/2/8.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import Foundation

/// 关联对象的便捷方法
/// 假设在属性上下文中，可以省略 key 的指定
///   var test: String {
///      get { getAssociatedObject() as? String }
///      set { setAssociatedObject(newValue) }
///   }
extension NSObjectProtocol {
    /// 获取关联对象
    public func getAssociatedObject(key: String = #function) -> Any? {
        objc_getAssociatedObject(self, Selector(key).utf8Start)
    }

    /// 设置关联对象
    public func setAssociatedObject(_ value: Any?,
                                    key: String = #function,
                                    policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        objc_setAssociatedObject(self, Selector(key).utf8Start, value, policy)
    }

    /// 懒加载形式创建关联对象
    /// 首次调用这个方法，它会执行 `maker` 进行对象的创建，并将对象关联到 ObjC Runtime
    /// - Parameter maker: 创建对象的闭包
    public func lazyVarAssociatedObject<T>(_ maker: () -> T, key: String = #function) -> T {
        (objc_getAssociatedObject(self, Selector(key).utf8Start) as? T) ?? {
            let object = maker()
            objc_setAssociatedObject(self, Selector(key).utf8Start, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return object
        }()
    }
}

extension NSObject {
    /// weak 包装器
    private struct WeakWrapper {
        weak var value: AnyObject?
        init?(_ value: AnyObject?) {
            if value == nil { return nil }
            self.value = value
        }
    }

    /// 强引用关联对象
    @objc
    @available(swift, obsoleted: 1.0)
    dynamic
    public func associateValue(_ value: Any?, forKey key: String) {
        objc_setAssociatedObject(self, Selector(key).utf8Start, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    /// 弱引用关联对象
    @objc
    @available(swift, obsoleted: 1.0)
    dynamic
    public func weaklyAssociateValue(_ value: AnyObject?, forKey key: String) {
        objc_setAssociatedObject(self, Selector(key).utf8Start, WeakWrapper(value), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    /// 复制关联对象
    @objc
    @available(swift, obsoleted: 1.0)
    dynamic
    public func copyAssociateValue(_ value: Any?, forKey key: String) {
        objc_setAssociatedObject(self, Selector(key).utf8Start, value, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }

    /// 获取关联对象
    @objc
    @available(swift, obsoleted: 1.0)
    dynamic
    public func associatedValueForKey(_ key: String) -> Any? {
        let obj = objc_getAssociatedObject(self, Selector(key).utf8Start)
        if let weakObj = obj as? WeakWrapper {
            return weakObj.value
        }
        return obj
    }
}

extension Selector {
    /// 获取 selector 全局唯一指针
    fileprivate var utf8Start: UnsafePointer<Int8> {
        unsafeBitCast(self, to: UnsafePointer<Int8>.self)
    }
}
