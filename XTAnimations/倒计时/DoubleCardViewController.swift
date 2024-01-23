//
//  DoubleCardViewController.swift
//  XTAnimations
//
//  Created by summerxx on 2023/7/12.
//  Copyright © 2023 夏天然后. All rights reserved.
//


import UIKit

class DoubleCardViewController: UIViewController {

    var countdownTimer: CountdownTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // 创建倒计时器并设置回调
        countdownTimer = CountdownTimer(totalTime: 10)
        // 停止上一次的
        countdownTimer?.stop()
        // 重新开始
        countdownTimer?.start()
        countdownTimer?.countdownCallback = { [weak self] currentTime in

            self?.label.text = currentTime
        }
        countdownTimer?.countdownEndCallback = { [weak self] in
            guard let `self` = self else { return }
        }

        view += label
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(100, 50))
        }
    }

    lazy var label = UILabel().then {
        $0.textColor = .black
    }
}

class CountdownTimer {

    var timer: Timer?
    var totalTime: Double
    var currentTime: Double

    var countdownCallback: ((String) -> Void)?

    var countdownEndCallback: (() -> Void)?

    init(totalTime: Double) {
        self.totalTime = totalTime
        self.currentTime = totalTime
    }

    func start() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }

    @objc func updateCountdown() {
        if currentTime > 0 {
            currentTime -= 0.1

            if currentTime <= 5.0 && currentTime > 0 {
                // 当剩余时间小于等于5秒时，每0.1秒回调一次
                let str = String(format: "%.1f", currentTime) + "s"
                countdownCallback?(str)

                print("zac_logger1 === \(str)")
            } else if currentTime > 5 {

                let str = String(format: "%.0f", currentTime) + "s"
                countdownCallback?(str)
                print("zac_logger2 === \(str)")
            }
        } else {
            // 倒计时结束，停止定时器
            countdownCallback?("0s")
            stop()
            countdownEndCallback?()
        }
    }

    func stop() {
        timer?.invalidate()
    }
}
