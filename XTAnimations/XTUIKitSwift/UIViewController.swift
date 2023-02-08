//
//  LogSwiftPointer.swift
//  XTAnimations
//
//  Created by summerxx on 2023/2/8.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    /// 打印对象的指针地址
    func printPointer<T>(ptr: UnsafePointer<T>) {
        print(ptr)
    }
}
