//
//  ThemeCGColorPicker.swift
//  SwiftTheme
//
//  Created by Gesen on 2017/1/28.
//  Copyright © 2017年 Gesen. All rights reserved.
//

import UIKit

@objc public final class ThemeCGColorPicker: ThemePicker {
    
    public convenience init(keyPath: String) {
        self.init(v: { ThemeManager.color(for: keyPath)?.cgColor })
    }
    
    public convenience init(keyPath: String, map: @escaping (Any?) -> CGColor?) {
        self.init(v: { map(ThemeManager.value(for: keyPath)) })
    }
    
    public convenience init(colors: String...) {
        self.init(v: { ThemeManager.colorElement(for: colors)?.cgColor })
    }
    
    public convenience init(colors: UIColor...) {
        self.init(v: { ThemeManager.element(for: colors)?.cgColor })
    }
    
    public convenience init(colors: CGColor...) {
        self.init(v: { ThemeManager.element(for: colors) })
    }
    
    public required convenience init(arrayLiteral elements: String...) {
        self.init(v: { ThemeManager.colorElement(for: elements)?.cgColor })
    }
    
    public required convenience init(stringLiteral value: String) {
        self.init(keyPath: value)
    }
    
    public required convenience init(unicodeScalarLiteral value: String) {
        self.init(keyPath: value)
    }
    
    public required convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(keyPath: value)
    }
    
}

@objc public extension ThemeCGColorPicker {
    
    class func pickerWithKeyPath(_ keyPath: String) -> ThemeCGColorPicker {
        return ThemeCGColorPicker(keyPath: keyPath)
    }
    
    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> CGColor?) -> ThemeCGColorPicker {
        return ThemeCGColorPicker(keyPath: keyPath, map: map)
    }
    
    class func pickerWithColors(_ colors: [String]) -> ThemeCGColorPicker {
        return ThemeCGColorPicker(v: { ThemeManager.colorElement(for: colors)?.cgColor })
    }
    
    class func pickerWithUIColors(_ colors: [UIColor]) -> ThemeCGColorPicker {
        return ThemeCGColorPicker(v: { ThemeManager.element(for: colors)?.cgColor })
    }
    
}

extension ThemeCGColorPicker: ExpressibleByArrayLiteral {}
extension ThemeCGColorPicker: ExpressibleByStringLiteral {}
