//
//  NSAttributedStringJoiner.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/25.
//  Copyright © 2023 夏天然后. All rights reserved.
//

// 为 NSAttributedString快速设置各种属性

/*

 举个🌰:

 NSAttributedString {
     ASpace(9)
     AImage("live_im_official")
         .size(10, 10)
     ASpace(7)
     AText("Hourly ranking 20")
         .foregroundColor(UIColor(0xffffff))
         .font(UIFont.ubuntu(.regular, pixels: 14))
 }

 */
import UIKit

/// 属性表类型
public typealias Attributes = [NSAttributedString.Key: Any]

/// `NSAttributedString` 的包装器
public protocol NSAttributedStringWrapper {
    /// 被包装的 `NSAttributedString`
    var attributedString: NSAttributedString? { get }

    /// 属性表
    var attributes: Attributes { get }
}

/// 文字
public struct AText: NSAttributedStringWrapper {
    public var attributedString: NSAttributedString? {
        text.map { NSAttributedString(string: $0, attributes: attributes) }
    }

    public var attributes: Attributes = [:]

    fileprivate var text: String?

    /// 使用 `String` 创建
    public init(_ text: String?, _ attributes: Attributes? = nil) {
        self.text = text
        if let attributes = attributes {
            self.attributes = attributes
        }
    }

    /// 使用 `Int` 创建
    public init(_ number: Int, _ attributes: Attributes? = nil) {
        self.init("\(number)", attributes)
    }
}

/// 图片
public struct AImage: NSAttributedStringWrapper {
    /// 图片对齐方式
    public enum Alignment {
        /// 与前面的文字居中对齐
        case before

        /// 与后面的文字居中对齐
        case after
    }

    public var attributedString: NSAttributedString? {
        NSAttributedString(attachment: attachment)
    }

    public var attributes: Attributes = [:]

    /// 附件
    fileprivate var attachment = NSTextAttachment()

    /// 对齐方式
    fileprivate var alignment = Alignment.after

    /// 使用附件对象创建
    fileprivate init(_ attachment: NSTextAttachment, _ alignment: Alignment) {
        self.attachment = attachment
        self.alignment = alignment
    }

    /// 创建图片
    /// - Parameters:
    ///   - image: 图片对象
    ///   - alignment: 对齐方式，默认与后面文字垂直对齐
    public init(_ image: UIImage?) {
        attachment.image = image
    }

    /// 创建图片
    /// - Parameters:
    ///   - image: 图片路径
    ///   - alignment: 对齐方式，默认与后面文字垂直对齐
    public init(_ imageName: String, fileID: String = #fileID) {
        attachment.image = UIImage(named: imageName)
    }
}

/// 间隔
public struct ASpace: NSAttributedStringWrapper {
    public var attributedString: NSAttributedString? {
        NSAttributedString(attachment: NSTextAttachment().then {
            $0.bounds = CGRect(0, 0, space, 0)
        })
    }

    public var attributes: Attributes = [:]

    fileprivate var space: CGFloat = 0

    /// 指定长度的间隔
    public init(_ space: CGFloat = 20) {
        self.space = space
    }
}

/// 空内容
struct AEmpty: NSAttributedStringWrapper {
    let attributedString: NSAttributedString? = nil
    let attributes: Attributes = [:]
}

/// 组
struct AGroup: NSAttributedStringWrapper {
    var attributedString: NSAttributedString? {
        NSMutableAttributedString(string: "").then {
            for w in wrappers {
                if let attributedString = w.attributedString {
                    $0.append(attributedString)
                }
            }
        }
    }

    let attributes: Attributes = [:]

    fileprivate var wrappers: [NSAttributedStringWrapper] = []

    init(_ wrappers: [NSAttributedStringWrapper]) {
        self.wrappers = wrappers
    }
}

extension AText {
    /// 设置属性
    private func setAttribute(_ key: NSAttributedString.Key, _ value: Any?) -> AText {
        var attributes = attributes
        if let value = value {
            attributes[key] = value
        } else {
            attributes.removeValue(forKey: key)
        }
        return AText(text, attributes)
    }

    /// 设置属性
    private func setAttributes(_ newAttributes: [NSAttributedString.Key: Any?]) -> AText {
        var attributes = attributes

        newAttributes.forEach {
            if let value = $0.value {
                attributes[$0.key] = value
            } else {
                attributes.removeValue(forKey: $0.key)
            }
        }

        return AText(text, attributes)
    }

    /// 获取段落样式对象
    private func getMutableParagraphStyle() -> NSMutableParagraphStyle {
        if let mps = attributes[.paragraphStyle] as? NSMutableParagraphStyle {
            return mps
        }

        if let ps = attributes[.paragraphStyle] as? NSParagraphStyle,
           let mps = ps.mutableCopy() as? NSMutableParagraphStyle {
            return mps
        }

        return NSMutableParagraphStyle()
    }

    /// 文字颜色
    public func foregroundColor(_ color: UIColor?) -> AText {
        setAttribute(.foregroundColor, color)
    }

    /// 文字颜色
    public func foregroundColor(_ color: ColorRGB) -> Self {
        setAttribute(.foregroundColor, UIColor(color))
    }

    /// 字体
    public func font(_ font: UIFont?) -> AText {
        setAttribute(.font, font)
    }

    /// 填充颜色
    public func strokeColor(_ color: ColorRGB) -> AText {
        setAttribute(.strokeColor, font)
    }

    /// 填充宽度
    public func strokeWidth(_ strokeWidth: CGFloat) -> AText {
        setAttribute(.strokeWidth, strokeWidth)
    }

    /// ubuntu Light
    public func ubuntuLight(_ pixels: CGFloat) -> AText {
        setAttribute(.font, UIFont.ubuntu(.light, pixels: pixels))
    }

    /// ubuntu Regular
    public func ubuntuRegular(_ pixels: CGFloat) -> AText {
        setAttribute(.font, UIFont.ubuntu(.regular, pixels: pixels))
    }

    /// ubuntu Medium
    public func ubuntuMedium(_ pixels: CGFloat) -> AText {
        setAttribute(.font, UIFont.ubuntu(.medium, pixels: pixels))
    }

    /// ubuntu Semibold
    public func ubuntuSemibold(_ pixels: CGFloat) -> AText {
        setAttribute(.font, UIFont.ubuntu(.semibold, pixels: pixels))
    }

    /// 基线偏移值
    public func baselineOffset(_ offset: CGFloat) -> AText {
        setAttribute(.baselineOffset, offset)
    }

    /// 行间距
    public func lineSpacing(_ spacing: CGFloat) -> AText {
        let paragraphStyle = getMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        return setAttribute(.paragraphStyle, paragraphStyle)
    }

    /// 对齐方式
    public func alignment(_ alignment: NSTextAlignment) -> AText {
        let paragraphStyle = getMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        return setAttribute(.paragraphStyle, paragraphStyle)
    }

    /// 删除线
    public func strikethrough(style: NSUnderlineStyle, color: UIColor? = nil) -> AText {
        if let color = color {
            return setAttributes([
                .strikethroughStyle: style.rawValue,
                .strikethroughColor: color,
            ])
        } else {
            return setAttributes([.strikethroughStyle: style.rawValue])
        }
    }

    /// 字符间距
    public func kern(_ spacing: CGFloat) -> AText {
        setAttribute(.kern, spacing)
    }
}

extension AImage {
    /// 对齐方式
    public func alignment(_ alignment: Alignment) -> AImage {
        AImage(attachment, alignment)
    }

    /// 指定图片大小
    public func size(_ width: CGFloat, _ height: CGFloat) -> AImage {
        attachment.image = attachment.image?.scaling(to: CGSize(width, height))
        return self
    }
}

/// NSAttributedString 连接器
@resultBuilder
public enum NSAttributedStringJoiner {
    /// 对应空方法体
    public static func buildBlock() -> NSAttributedStringWrapper {
        AEmpty()
    }

    /// 对应多条语句
    public static func buildBlock(_ components: NSAttributedStringWrapper...) -> NSAttributedStringWrapper {
        components.updateAttachmentsBounds()
        return AGroup(components)
    }

    /// 对应无 else 的 if 语句，以及 if let = xxx 的解包语句
    public static func buildOptional(_ component: NSAttributedStringWrapper?) -> NSAttributedStringWrapper {
        component ?? AEmpty()
    }

    /// 对应含有 else 的 if 语句的 then 方法体
    public static func buildEither(first component: NSAttributedStringWrapper) -> NSAttributedStringWrapper {
        component
    }

    /// 对应含有 else 的 if 语句的 else 方法体
    public static func buildEither(second component: NSAttributedStringWrapper) -> NSAttributedStringWrapper {
        component
    }

    /// 对应 for ... in 的方法体
    public static func buildArray(_ components: [NSAttributedStringWrapper]) -> NSAttributedStringWrapper {
        components.updateAttachmentsBounds()
        return AGroup(components)
    }
}

extension NSAttributedString {
    /// 使用连接器构建属性字符串
    public convenience init(@NSAttributedStringJoiner _ joiner: () -> NSAttributedStringWrapper) {
        if let attributedString = joiner().attributedString {
            self.init(attributedString: attributedString)
        } else {
            self.init(string: "")
        }
    }
}

extension Array where Element == NSAttributedStringWrapper {
    /// 更新附件的显示位置和大小
    fileprivate func updateAttachmentsBounds() {
        for index in 0..<count {
            guard let wrapper = self[index] as? AImage,
                  let image = wrapper.attachment.image,
                  index + 1 < count
            else {
                continue
            }

            let range: [Int]
            switch wrapper.alignment {
            case .after: range = [Int](index..<count)
            case .before: range = (0..<index).reversed()
            }

            for i in range {
                if let font = font(at: i) {
                    let top = ((font.ascender + font.descender) - image.size.height) / 2
                    wrapper.attachment.bounds = CGRect(0, top, image.size)
                }
            }
        }
    }

    /// 获得在 `index` 位置上定义的字体
    private func font(at index: Int) -> UIFont? {
        guard let attrText = self[index].attributedString else {
            return nil
        }
        let attributes = attrText.attributes(at: 0, effectiveRange: nil)
        return attributes[.font] as? UIFont
    }
}

