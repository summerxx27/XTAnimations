//
//  UICollectionView.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/18.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    /// 注册 cell 类，identifier 为类名字符串
    public func registerCell<T: UICollectionViewCell>(_ type: T.Type) {
        let identifier = NSStringFromClass(type.self)
        register(type, forCellWithReuseIdentifier: identifier)
    }

    /// 通过类名获取注册的 cell
    public func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = NSStringFromClass(type.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("\(type.self) was not registered")
        }
        return cell
    }
}

extension UICollectionView {
    /// 注册 header 类，identifier 为类名字符串
    public func registerHeader<T: UICollectionReusableView>(_ type: T.Type) {
        let identifier = NSStringFromClass(type.self)
        register(type,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: identifier)
    }

    /// 通过类名获取注册的 header
    public func dequeueReusableHeader<T: UICollectionReusableView>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = NSStringFromClass(type.self)
        guard let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                            withReuseIdentifier: identifier,
                                                            for: indexPath) as? T
        else {
            fatalError("\(type.self) was not registered")
        }
        return header
    }
}

extension UICollectionView {
    /// 注册 footer 类，identifier 为类名字符串
    public func registerFooter<T: UICollectionReusableView>(_ type: T.Type) {
        let identifier = NSStringFromClass(type.self)
        register(type,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: identifier)
    }

    /// 通过类名获取注册的 footer
    public func dequeueReusableFooter<T: UICollectionReusableView>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = NSStringFromClass(type.self)
        guard let footer = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                            withReuseIdentifier: identifier,
                                                            for: indexPath) as? T
        else {
            fatalError("\(type.self) was not registered")
        }
        return footer
    }
}
