//
//  UITableView.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/28.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit

/*
 eg:

 $0.registerCell(UITableViewCell.self)
 let cell = tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)

 */
extension UITableView {

    /// 注册 cell 类，identifier 为类名字符串
    public func registerCell<T: UITableViewCell>(_ type: T.Type) {
        let identifier = NSStringFromClass(type.self)
        register(type, forCellReuseIdentifier: identifier)
    }

    /// 通过类名获取注册的 cell
    public func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let identifier = NSStringFromClass(type.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("\(type.self) was not registered")
        }
        return cell
    }
}
