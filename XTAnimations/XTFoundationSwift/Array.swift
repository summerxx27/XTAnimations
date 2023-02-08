//
//  Array.swift
//  XTAnimations
//
//  Created by summerxx on 2023/2/8.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import Foundation

extension Array {
    /// 取值之前做判断，如果越界返回 nil
    public subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }

    /// 取值之前做判断，如果越界则返回 deafutValue
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        (index >= 0 && index < endIndex) ? self[index] : defaultValue()
    }

    /// 写入文件
    @discardableResult
    public func write(toFile path: String, atomically useAuxiliaryFile: Bool) -> Bool {
        (self as NSArray).write(toFile: path, atomically: useAuxiliaryFile)
    }

    /// 读取文件
    /// - Parameter path: 文件全路径
    /// - Returns: 数组
    public func read(path: String) -> [Element]? {
        NSArray(contentsOfFile: path) as? [Element]
    }
}

precedencegroup ArrayAppendingPrecedence {
    associativity: right
    higherThan: AssignmentPrecedence
}

infix operator <<< : ArrayAppendingPrecedence

extension Array {
    /// 将右侧对象追加到数组中（.append 方法的语法糖）
    public static func << (lhs: inout [Element], rhs: Element) {
        lhs.append(rhs)
    }

    /// 将右侧数组中的所有对象追加到左侧数组中（.append(contentsOf:) 方法的语法糖）
    public static func <<< (lhs: inout [Element], rhs: [Element]) {
        lhs.append(contentsOf: rhs)
    }
}
