//
//  PipViewController.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/28.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import AVKit
import AVFoundation
import SnapKit

/// 画中画的大小跟你正在用player 播放的视频相关
///
class PipViewController: UIViewController, AVPictureInPictureControllerDelegate {

    private var displayLink: CADisplayLink?
    private var isRunning = false

    // 播放器
    private var playerLayer: AVPlayerLayer!

    // 测试代替拉流
    private var streamPlayer: AVPlayer!

    var displayLinkThread = DisplayLinkThread()

    private var player: AVPlayer!

    var customView = UIView().then {
        $0.backgroundColor = .cyan
    }

    // 画中画
    var pipController: AVPictureInPictureController!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        print("画中画初始化前：\(UIApplication.shared.windows)")

        if AVPictureInPictureController.isPictureInPictureSupported() {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            } catch {
                print(error)
            }
            setupUI()
            setupPlayer()
            setupPip()
        } else {
            let alertVC = UIAlertController(title: "功能需支持 iOS 14 及以上版本使用，请升级手机系统", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
            alertVC.addAction(cancelAction)
            present(alertVC, animated: true)
        }

    }

    private func setupUI() {

        let pipButton = UIButton(type: .system)
        view.addSubview(pipButton)
        pipButton.setTitle("打开/关闭画中画", for: .normal)
        pipButton.addTarget(self, action: #selector(pipButtonClicked), for: .touchUpInside)
        pipButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }

    }

    // 配置播放器
    private func setupPlayer() {
        playerLayer = AVPlayerLayer()
        playerLayer.backgroundColor = UIColor.cyan.cgColor
        playerLayer.frame = .init(x: 0, y: 90, width: UIScreen.width, height: 250)

        let mp4Video = Bundle.main.url(forResource: "gift_demo5", withExtension: "mp4")
        let asset = AVAsset.init(url: mp4Video!)
        let playerItem = AVPlayerItem.init(asset: asset)

        player = AVPlayer.init(playerItem: playerItem)
        playerLayer.player = player
        player.isMuted = true
        player.allowsExternalPlayback = true
        view.layer.addSublayer(playerLayer)

        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerItem, queue: .main) { [weak playerItem] _ in
            // 循环播放
            playerItem?.seek(to: CMTime.zero)
            self.player.play()
        }
    }

    // 配置画中画
    private func setupPip() {
        pipController = AVPictureInPictureController.init(playerLayer: playerLayer)!
        pipController.delegate = self
        // 隐藏播放按钮、快进快退按钮
        pipController.setValue(1, forKey: "controlsStyle")
    }

    // 开启/关闭 画中画
    @objc private func pipButtonClicked() {
        if pipController.isPictureInPictureActive {
            pipController.stopPictureInPicture()
        } else {
            pipController.startPictureInPicture()
        }
    }

    // MARK: - Delegate

    func pictureInPictureControllerWillStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        // 打印所有window，你会发现这个时候多了一个window
        print("画中画初始化后：\(UIApplication.shared.windows)")
        // 注意是 first window
        let window = UIApplication.shared.windows.first
        // 把自定义view加到画中画上
        window?.addSubview(customView)
        // 使用自动布局
        customView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10))
        }

        let mp4Video = Bundle.main.url(forResource: "gift_demo5", withExtension: "mp4")
        guard let videoURL = mp4Video else { return }
        let playerItem = AVPlayerItem(url: videoURL)
        streamPlayer = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: streamPlayer)
        playerLayer.frame = CGRect(0, 0, 200, 300)
        customView.layer.addSublayer(playerLayer)

        // 监听播放结束事件
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerItem, queue: .main) { [weak playerItem] _ in
            // 循环播放
            playerItem?.seek(to: CMTime.zero)
            self.streamPlayer.play()
        }
        streamPlayer.play()
    }

    func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("画中画弹出后：\(UIApplication.shared.windows)")
        start()
    }

    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        stop()
    }

    deinit {
        print("PipViewController")
    }

}

extension PipViewController {

    func start() {
        if isRunning {
            return
        }

        // 创建 CADisplayLink 对象并添加到当前线程的 RunLoop 中
        displayLink = CADisplayLink(target: self, selector: #selector(handleDisplayLink))
        displayLink?.add(to: .current, forMode: .default)

        isRunning = true
    }

    func stop() {
        if !isRunning {
            return
        }

        // 从 RunLoop 中移除 CADisplayLink 对象
        displayLink?.remove(from: .current, forMode: .default)
        displayLink?.invalidate()
        displayLink = nil

        isRunning = false
    }

    @objc private func handleDisplayLink() {
        // 这里可以执行一些需要常驻后台线程执行的操作
        customView.backgroundColor = .randomColor
    }
}
class DisplayLinkThread {

}

