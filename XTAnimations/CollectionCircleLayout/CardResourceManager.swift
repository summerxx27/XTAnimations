//
//  CardResourceManager.swift
//  XTAnimations
//
//  Created by summerxx on 2024/12/11.
//  Copyright © 2024 夏天然后. All rights reserved.
//

import Foundation

class CardResourceManager {
    // 单例实例
    static let shared = CardResourceManager()

    // 私有化初始化方法，确保不能在外部实例化
    private init() {}

    // 资源列表
    private var resources: [String] = [
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
    ]

    // 当前游标
    private var backIndex = 0
    private var forwardIndex = 9

    // 获取资源列表
    func getResources() -> [String] {
        return resources
    }

    // 设置资源列表
    func setResources(_ newResources: [String]) {
        resources = newResources
        backIndex = 0
        forwardIndex = resources.count - 1
    }

    // 获取下一个后方的资源
    func acquireBack() -> String? {
        guard !resources.isEmpty else { return nil }
        let letter = resources[backIndex]

        // 下标更新
        backIndex = (backIndex + 1) % resources.count
        return letter
    }

    // 释放后方的资源
    func releaseBack() {
        backIndex = (backIndex - 1 + resources.count) % resources.count
    }

    // 获取下一个前方的资源
    func acquireForward() -> String? {
        guard !resources.isEmpty else { return nil }
        let letter = resources[forwardIndex]

        // 下标更新
        forwardIndex = (forwardIndex - 1 + resources.count) % resources.count
        return letter
    }

    // 释放前方的资源
    func releaseForward() {
        forwardIndex = (forwardIndex + 1) % resources.count
    }
}
