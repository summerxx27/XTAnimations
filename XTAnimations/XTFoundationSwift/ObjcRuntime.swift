//
//  ObjcRuntime.swift
//  XTAnimations
//
//  Created by summerxx on 2023/2/8.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import Foundation
import ObjectiveC

/// 封装 Objective-C Runtime 的一些方法
/// 后续有相关于 runtime 的封装都放在这里

public enum ObjcRuntime {

    /// 交换实例方法的实现
    /// - Parameters:
    ///   - klass: 需要交换的类
    ///   - original: 原方法
    ///   - swizzled: 目标方法
    public static func swizzleMethod(class klass: AnyClass, from original: Selector, to swizzled: Selector) {
        guard let originalMethod = class_getInstanceMethod(klass, original),
              let swizzledMethod = class_getInstanceMethod(klass, swizzled) else {
            assertionFailure("Method not found")
            return
        }

        let didAddMethod = class_addMethod(klass,
                                           original,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))

        if didAddMethod {
            class_replaceMethod(klass,
                                swizzled,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
