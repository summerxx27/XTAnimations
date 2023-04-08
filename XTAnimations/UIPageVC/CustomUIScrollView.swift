//
//  CustomUIScrollView.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/29.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit

final class HorizontalScrollView: UIScrollView {
    required init?(coder: NSCoder) { fatalError() }

    override init(frame: CGRect) {
        super.init(frame: frame)
        showsHorizontalScrollIndicator = false
        keyboardDismissMode = .onDrag
        isPagingEnabled = true
        bounces = false
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        isScrollEnabled = (view as? UIScrollView) == nil
        return view
    }
}
