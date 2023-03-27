//
//  XTPageViewController.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/27.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    /// Max count
    static let max = 5

    /// Fist time
    private var isFirstTime: Bool = true

    /// Start index
    private let startIndex = 0

    /// End index
    private var endIndex = 0

    /// Current index
    private var currentIndex = 0

    /// Current viewController
    private var currentPageVC = LivingViewController()

    /// Next ViewController
    private var nextPageVC = LivingViewController()

    /// Prev ViewController
    private var prevPageVC = LivingViewController()

    /// Live data: set value after get net data
    var liveData = [0, 1, 2, 3, 4] {
        didSet {

        }
    }

    private lazy  var scrollView = UIScrollView().then {
        $0.frame = CGRect(0, 0, UIScreen.width, UIScreen.height)
        $0.contentSize = CGSize.zero
        $0.isPagingEnabled = true
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
        currentIndex - 1 >= 0 ? currentIndex - 1 : -1
    }

    /// Next Index
    func nextIndex() -> Int {
        currentIndex + 1 <= endIndex ? currentIndex + 1 : -1
    }

    func scrollAtIndex(_ index: Int) {

        if index == currentIndex && !isFirstTime {
            return
        }

        currentIndex = index

        var liveVC = liveViewControllerAt(index)

        removeViewController(currentPageVC)
        addViewController(liveVC, index: index)
        currentPageVC = liveVC

        if nextIndex() != -1 {
            liveVC = liveViewControllerAt(nextIndex())
            removeViewController(nextPageVC)
            addViewController(liveVC, index: nextIndex())
            nextPageVC = liveVC
        }

        if prevIndex() != -1 {
            liveVC = liveViewControllerAt(prevIndex())
            removeViewController(prevPageVC)
            addViewController(liveVC, index: prevIndex())
            prevPageVC = liveVC
        }

        view.bringSubviewToFront(currentPageVC.view)

        if liveData.count - index <= PageViewController.max {
            // 重新加载数据
            print("超过限制了~")
        }

        isFirstTime = false
    }

    func liveViewControllerAt(_ index: Int) -> LivingViewController {
        if index >= liveData.count {
            debugPrint("异常")
            return UIViewController() as! LivingViewController
        }
        return LivingViewController()
    }
}

extension PageViewController {

    /// remove viewController
    func removeViewController(_ vc: LivingViewController) {
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }


    /// Add viewController
    /// - Parameters:
    ///   - vc: vc
    ///   - index: index
    func addViewController(_ vc: LivingViewController, index: Int) {
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

    private func scrollViewDidAction(_ scrollView: UIScrollView) {
        let index = (Int)(scrollView.contentOffset.y / UIScreen.height)
        if scrollView.contentOffset.y < CGFloat((currentIndex - startIndex)) * UIScreen.height - UIScreen.height / 2 ||
            scrollView.contentOffset.y > CGFloat((currentIndex - startIndex)) * UIScreen.height + UIScreen.height / 2 {
            scrollAtIndex(index + startIndex)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > CGFloat(currentIndex) * UIScreen.height + UIScreen.height / 2 {
            print("需要开始加载了")
        }
    }

}



