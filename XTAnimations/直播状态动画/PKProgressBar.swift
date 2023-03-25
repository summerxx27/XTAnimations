//
//  LiveRoomPkProgressBar.swift
//  live
//
//  Created by summerxx on 2023/3/25.
//  Copyright © 2023 weo. All rights reserved.
//

import UIKit

/// PK 进度条
class PKProgressBar: UIView {

    /// 左侧进度
    private var leftProgressLayer = CAGradientLayer().then {
        $0.locations = [0, 1]
        $0.startPoint = CGPoint(x: 0.25, y: 0.5)
        $0.endPoint = CGPoint(x: 0.75, y: 0.5)
    }

    /// 右侧进度
    private var rightProgressLayer = CAGradientLayer().then {
        $0.locations = [0, 1]
        $0.startPoint = CGPoint(x: 0.25, y: 0.5)
        $0.endPoint = CGPoint(x: 0.75, y: 0.5)
    }

    /// 左侧文本
    private var leftTextLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.ubuntu(.bold, pixels: 14)
        $0.textAlignment = .left
    }

    /// 右侧文本
    private var rightTextLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.ubuntu(.bold, pixels: 14)
        $0.textAlignment = .right
    }

    /// 中间白色区域
    private var moveView = UIView().then {
        $0.backgroundColor = .white
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor,
          UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor,
          UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor,
          UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor,
          UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor
        ]

        layer0.locations = [0, 0.32, 0.49, 0.68, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 0.1, tx: 0, ty: 0.45))
        layer0.bounds = $0.bounds.insetBy(dx: -0.5*$0.bounds.size.width, dy: -0.5*$0.bounds.size.height)
        layer0.position = $0.center
        $0.layer.addSublayer(layer0)
    }

    /// 高度
    private let progressViewHeight: CGFloat = 20.0

    /// 边界
    private let boundary: CGFloat = 40.0

    private let progressColor1: [CGColor] = [UIColor(0xFC4911).cgColor, UIColor(0xFFDB11).cgColor]
    private let progressColor2: [CGColor] = [UIColor(0x49CBFF).cgColor, UIColor(0x00AAFF).cgColor]

    private var leftProgress: CGFloat = 0.0
    private var rightProgress: CGFloat = 0.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProgressView()
        setupMoveView()
        setupCountView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupProgressView() {
        self.backgroundColor = UIColor.lightGray

        leftProgressLayer.colors = progressColor1
        leftProgressLayer.frame = CGRect(x: 0, y: 0, width: 0, height: progressViewHeight)

        rightProgressLayer.colors = progressColor2
        rightProgressLayer.frame = CGRect(x: self.frame.width, y: 0, width: 0, height: progressViewHeight)

        self.layer.addSublayer(leftProgressLayer)
        self.layer.addSublayer(rightProgressLayer)
    }

    private func setupMoveView() {
        moveView.backgroundColor = UIColor.white
        moveView.frame = CGRect(x: 0, y: 0, width: 8, height: progressViewHeight)
        self.addSubview(moveView)
    }

    private func setupCountView() {
        self.addSubview(leftTextLabel)
        self.addSubview(rightTextLabel)
        leftTextLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(0)
            $0.left.equalTo(4)
        }
        rightTextLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(0)
            $0.right.equalTo(-4)
        }
    }

    /// 设置进度
    /// - Parameters:
    ///   - left: 左侧进度
    func updateProgress(left: CGFloat) {

        leftProgress = left

        var leftWidth = self.frame.width * leftProgress

        // 设置边界
        if leftWidth < boundary {
            leftWidth = boundary
        }

        if leftWidth > (UIScreen.width - boundary) {
            leftWidth = UIScreen.width - boundary
        }

        let rightWidth = self.frame.width - leftWidth

        UIView.animate(withDuration: 0.2) {
            self.leftProgressLayer.frame = CGRect(x: 0, y: 0, width: leftWidth, height: self.progressViewHeight)
            self.rightProgressLayer.frame = CGRect(x: self.frame.width - rightWidth, y: 0, width: rightWidth, height: self.progressViewHeight)

            var moveViewX = self.frame.width * self.leftProgress - self.moveView.frame.width/2

            if moveViewX < self.boundary {
                moveViewX = self.boundary
            }

            if moveViewX > (UIScreen.width - self.boundary) {
                moveViewX = UIScreen.width - self.boundary
            }

            self.moveView.frame.origin.x = moveViewX
        }
    }

    /// TODO: 暂时分开赋值, 实际再修改
    func updateText(leftText: String, rightText: String) {
        leftTextLabel.text = leftText
        rightTextLabel.text = rightText
    }
}

