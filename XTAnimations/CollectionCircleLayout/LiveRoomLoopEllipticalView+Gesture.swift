//
//  LiveRoomLoopEllipticalView+Gesture.swift
//  XTAnimations
//
//  Created by summerxx on 2024/12/10.
//  Copyright © 2024 夏天然后. All rights reserved.
//

import Foundation

extension LiveRoomLoopEllipticalView {

    func configGusture() {
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panAction))
        addGestureRecognizer(pan)
    }

    @objc func panAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)

        // 获取拖动的增量
        let deltaX = translation.x - lastTranslation.x
        let newX = deltaX / 10 + lastAngle

        if newX > 360 {
            lastAngle = newX - 360
        } else if newX < 0 {
            lastAngle = 360 + newX
        } else {
            lastAngle = newX
        }
        rotationAngle = -lastAngle
    }
}
