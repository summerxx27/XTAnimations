//
//  UIImage.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/25.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit

extension UIImage {

    /// 根据分辨率缩放图片
    /// - Parameter size: 目标分辨率
    /// - Returns: 缩放后的图片对象
    func scaling(to size: CGSize) -> UIImage {
        let render = UIGraphicsImageRenderer(size: size)
        return render.image { _ in
            draw(in: CGRect(0, 0, size.rounding))
        }
    }
}
