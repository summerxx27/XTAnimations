//
//  String+Cal.swift
//  XTMovingView
//
//  Created by summerxx on 2020/7/16.
//  Copyright © 2020 summerxx. All rights reserved.
//

import Foundation
import UIKit

extension NSString {
    func calculateWidthWithAttributeText(dic: Dictionary<NSAttributedString.Key, Any>) -> Double {

        let rect = self.boundingRect(with: CGSize.init(width: 1000000000, height: 20), options: NSStringDrawingOptions.usesLineFragmentOrigin.union(NSStringDrawingOptions.usesFontLeading).union(NSStringDrawingOptions.usesDeviceMetrics), attributes: dic, context: nil)
        
        return Double(ceil(rect.size.width))
    }
}


