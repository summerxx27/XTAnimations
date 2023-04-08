//
//  XTPageViewController.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/27.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    /// error
    static let errorNotFound = -1

    /// Threshold value
    static let kPreloadThreshold = 2

    /// Fist time
    private var isFirstTime: Bool = true

    /// Start index
    private let startIndex = 0

    /// End index
    private var endIndex = 0

    /// Current index
    private var currentIndex = 0

    /// Current viewController
    var currentPageVC = PageSubViewController()

    /// Next ViewController
    private var nextPageVC = PageSubViewController()

    /// Prev ViewController
    private var prevPageVC = PageSubViewController()

    /// Live data: set value after get net data
    var liveData = [0, 1, 2, 3, 4] {
        didSet {

        }
    }

    lazy  var scrollView = UIScrollView().then {
        $0.frame = CGRect(0, 0, UIScreen.width, UIScreen.height)
        $0.contentSize = CGSize.zero
        $0.isPagingEnabled = true
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
        $0.contentInsetAdjustmentBehavior = .never
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "滚动容器"
        view += scrollView
        // TODO: resize after get net data
        resizeContentLength()
    }

    /// resize contentSize
    func resizeContentLength() {
        endIndex = liveData.count - 1
        let scrollLength = endIndex - startIndex + 1
        scrollView.contentSize = CGSize(UIScreen.width, UIScreen.height * (CGFloat)(scrollLength))
        scrollAtIndex(currentIndex)
        scrollView.contentOffset = CGPoint(0, CGRectGetMinY(currentPageVC.view.frame))
    }

    /// Prev Index
    func prevIndex() -> Int {
        currentIndex - 1 >= 0 ? currentIndex - 1 : PageViewController.errorNotFound
    }

    /// Next Index
    func nextIndex() -> Int {
        currentIndex + 1 <= endIndex ? currentIndex + 1 : PageViewController.errorNotFound
    }

    func scrollAtIndex(_ index: Int) {

        if index == currentIndex && !isFirstTime {
            return
        }

        currentIndex = index

        var vc = liveViewControllerAt(index)

        removeViewController(currentPageVC)
        addViewController(vc, index: index)
        currentPageVC = vc

        if nextIndex() != PageViewController.errorNotFound {
            vc = liveViewControllerAt(nextIndex())
            removeViewController(nextPageVC)
            addViewController(vc, index: nextIndex())
            nextPageVC = vc
        }

        if prevIndex() != PageViewController.errorNotFound {
            vc = liveViewControllerAt(prevIndex())
            removeViewController(prevPageVC)
            addViewController(vc, index: prevIndex())
            prevPageVC = vc
        }

        view.bringSubviewToFront(currentPageVC.view)

        if liveData.count - index <= PageViewController.kPreloadThreshold {
            // 预加载
            print("需要加载数据了~")
        }

        isFirstTime = false
    }

    func liveViewControllerAt(_ index: Int) -> PageSubViewController {
        if index >= liveData.count {
            debugPrint("异常")
            return UIViewController() as! PageSubViewController
        }
//        let model = self.liveData[safe: index]
//        let params: [String : Any] = [
//            "pageSource": LiveRoomPageSource.list.rawValue,
//            "roomInfo": model,
//        ]
        let vc = PageSubViewController()
//        vc.params = params
        return vc
    }

    func xxx(_ x: Bool) {
        self.scrollView.isScrollEnabled = x

    }
}

extension PageViewController {

    /// remove viewController
    func removeViewController(_ vc: PageSubViewController) {
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }


    /// Add viewController
    /// - Parameters:
    ///   - vc: vc
    ///   - index: index
    func addViewController(_ vc: PageSubViewController, index: Int) {
        vc.view.frame = CGRect(0, UIScreen.height * CGFloat((index - startIndex)), UIScreen.width, UIScreen.height)
        scrollView.addSubview(vc.view)
        addChild(vc)
    }
}

extension PageViewController {

    override func willMove(toParent parent: UIViewController?) {
        if (parent == nil) {
            // remove it from parent
            currentPageVC.willMove(toParent: parent)
        }
    }
}

// MARK: UIScrollViewDelegate
extension PageViewController: UIScrollViewDelegate {

    // User stop dragging UIScrollView，and the UIScrollView stop rolling
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidAction(scrollView)
        }
    }

    /// End Decelerating
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidAction(scrollView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

//        if currentPageVC.tableview {
//
//        }
        print("y === \(scrollView.contentOffset.y)")
        if scrollView.contentOffset.y > CGFloat(currentIndex) * UIScreen.height + UIScreen.height / 2 ||
            scrollView.contentOffset.y < CGFloat(currentIndex) * UIScreen.height - UIScreen.height / 2{
            print("需要开始加载了")
        }
    }
}

// MARK: Action
extension PageViewController {

    private func scrollViewDidAction(_ scrollView: UIScrollView) {
        let index = (Int)(scrollView.contentOffset.y / UIScreen.height)
        if scrollView.contentOffset.y < CGFloat((currentIndex - startIndex)) * UIScreen.height - UIScreen.height / 2 ||
            scrollView.contentOffset.y > CGFloat((currentIndex - startIndex)) * UIScreen.height + UIScreen.height / 2 {
            scrollAtIndex(index + startIndex)
        }
    }
}

extension PageViewController {

    // 处理通知的方法
    @objc func handleNotification(_ notification: Notification) {


        if let userInfo = notification.userInfo {
            let isScrollEnabled = userInfo["isScrollEnabled"] as! Bool
            // 处理接收到的值
            scrollView.isScrollEnabled = isScrollEnabled

        }
    }

}



