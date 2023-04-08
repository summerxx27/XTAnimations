//
//  CustomUITableView.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/29.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit

class CustomUITableView: UITableView, UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        false
    }
}
