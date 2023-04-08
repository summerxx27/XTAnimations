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

    var count = 1

    /// 这个当做是拉流的
    private var meidaPlayerView = PlayerView().then {
        $0.frame = CGRect(0, 0, UIScreen.width, 200)
//        guard let url = Bundle.main.url(forResource: "pip_video", withExtension: "mp4") else { return }
        guard let url = URL(string: "http://livestreamcdn.net:1935/ExtremaTV/ExtremaTV/playlist.m3u8") else { return }
        $0.player = AVPlayer(url: url)
        $0.player.play()
    }

    /// 这个是本地开启画中画Layer 层
    let playerLayer = AVPlayerLayer()

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

    // 配置本地播放器
    private func setupPlayer() {

        // 设置 AVPlayerLayer 的 frame 和 videoGravity
        playerLayer.frame = CGRect(0, 100, UIScreen.width, 200)
        playerLayer.videoGravity = .resizeAspectFill

        // 创建 AVPlayer 和 AVPlayerItem
//        guard let videoURL = Bundle.main.url(forResource: "pip_video", withExtension: "mp4") else { return }

        guard let videoURL = URL(string: "http://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/gear2/prog_index.m3u8") else { return }

        let player = AVPlayer(url: videoURL)
        let playerItem = AVPlayerItem(url: videoURL)

        // 监听 AVPlayerItem 播放完成的通知
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)

        // 将 AVPlayerItem 设置给 AVPlayer
        player.replaceCurrentItem(with: playerItem)

        // 将 AVPlayer 设置给 AVPlayerLayer
        playerLayer.player = player

        // 将 AVPlayerLayer 添加到 view 中
        view.layer.addSublayer(playerLayer)

        // 监听播放进度，并在需要循环播放时重新开始播放
        let duration = playerItem.asset.duration
        player.addBoundaryTimeObserver(forTimes: [NSValue(time: duration)], queue: .main) { [weak self] in
            self?.playerDidFinishPlaying()
        }

        // 开始播放
        player.play()
    }

    @objc func playerItemDidReachEnd() {
        playerLayer.player?.seek(to: .zero)

        print("视频循环播放")
    }

    func playerDidFinishPlaying() {
        playerLayer.player?.seek(to: .zero)
        playerLayer.player?.play()
        print("视频循环播放")
    }

    // 配置画中画
    private func setupPip() {
        pipController = AVPictureInPictureController.init(playerLayer: playerLayer)!
        pipController.delegate = self
        // 隐藏播放按钮、快进快退按钮
        pipController.setValue(1, forKey: "controlsStyle")
        if #available(iOS 14.2, *) {
            pipController.canStartPictureInPictureAutomaticallyFromInline = true
        } else {
            // Fallback on earlier versions
        }
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
        debugPrint(pictureInPictureControllerWillStartPictureInPicture)
    }

    func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        print("画中画弹出后：\(UIApplication.shared.windows)")
        start()
        // 打印所有window，你会发现这个时候多了一个window
        print("画中画初始化后：\(UIApplication.shared.windows)")
        // 注意是 first window
        let window = UIApplication.shared.windows.first

        meidaPlayerView.removeFromSuperview()
        // 把自定义view加到画中画上
        window?.addSubview(meidaPlayerView)
        meidaPlayerView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        meidaPlayerView.backgroundColor = .yellow
    }

    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        // 恢复
        stop()

    }

    deinit {
        print("PipViewController")
    }

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
        count += 1
        print("线程保活中\(count)")
    }
}
