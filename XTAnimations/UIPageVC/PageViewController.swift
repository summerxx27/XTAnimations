//
//  XTPageViewController.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/27.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    static let max = 5

    var isFirstTime: Bool = true

    let startIndex = 0

    var endIndex = 0

    var currentIndex = 0

    var currentPageVC = LivingViewController()

    var nextPageVC = LivingViewController()

    var prevPageVC = LivingViewController()

    var liveArray = [0, 1, 2, 3, 4]

    private lazy  var scrollView = UIScrollView().then {
        $0.frame = CGRect(0, 0, UIScreen.width, UIScreen.height)
        $0.contentSize = CGSize.zero
        $0.isPagingEnabled = true
        $0.delegate = self
        $0.contentInsetAdjustmentBehavior = .never
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "测试"
        view.backgroundColor = .systemPink
        view.addSubview(scrollView)
        // 获取数据后重新设置
        resizeContentLength()
    }

    /// 重置 contentSize
    func resizeContentLength() {
        endIndex = liveArray.count - 1
        let scrollLength = endIndex - startIndex + 1
        scrollView.contentSize = CGSize(UIScreen.width, UIScreen.height * (CGFloat)(scrollLength))
        scrollAtIndex(currentIndex)
        scrollView.contentOffset = CGPoint(0, CGRectGetMinY(currentPageVC.view.frame))
    }

    /// 前Index
    func prevIndex() -> Int {
        currentIndex - 1 >= 0 ? currentIndex - 1 : -1
    }

    /// 下一个Index
    func nextIndex() -> Int {
        currentIndex + 1 <= endIndex ? currentIndex + 1 : -1
    }

    func scrollAtIndex(_ index: Int) {

        if index == currentIndex && !isFirstTime {
            return
        }

        currentIndex = index

        var liveVC = liveViewControllerAt(index)

        removeViewController(liveVC: currentPageVC)
        addViewController(liveVC: liveVC, index: index)
        currentPageVC = liveVC

        if nextIndex() != -1 {
            liveVC = liveViewControllerAt(nextIndex())
            removeViewController(liveVC: nextPageVC)
            addViewController(liveVC: liveVC, index: nextIndex())
            nextPageVC = liveVC
        }

        if prevIndex() != -1 {
            liveVC = liveViewControllerAt(prevIndex())
            removeViewController(liveVC: prevPageVC)
            addViewController(liveVC: liveVC, index: prevIndex())
            prevPageVC = liveVC
        }

        view.bringSubviewToFront(currentPageVC.view)

        if liveArray.count - index <= PageViewController.max {
            // 重新加载数据
            print("到底了~")
        }

        isFirstTime = false
    }

    func liveViewControllerAt(_ index: Int) -> LivingViewController {
        if index >= self.liveArray.count {
            debugPrint("异常")
            return UIViewController() as! LivingViewController
        }
        return LivingViewController()
    }
}

extension PageViewController {

    /// 删除
    func removeViewController(liveVC: LivingViewController) {
        liveVC.view.removeFromSuperview()
        liveVC.removeFromParent()
    }

    /// 添加
    func addViewController(liveVC: LivingViewController, index: Int) {
        liveVC.view.frame = CGRect(0, UIScreen.height * CGFloat((index - startIndex)), UIScreen.width, UIScreen.height)
        scrollView.addSubview(liveVC.view)
        addChild(liveVC)
    }
}

extension PageViewController {

    override func willMove(toParent parent: UIViewController?) {
        if (parent == nil) {
            // 视图控制器即将从父视图控制器移除
            currentPageVC.willMove(toParent: parent)
        }
    }
}

// MARK: UIScrollViewDelegate
extension PageViewController: UIScrollViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            // 用户停止拖动 UIScrollView，且 UIScrollView 停止滚动
            // 在这里执行相关操作
            let index = (Int)(scrollView.contentOffset.y / UIScreen.height)

            if scrollView.contentOffset.y < CGFloat((currentIndex - startIndex)) * UIScreen.height - UIScreen.height / 2 ||
                scrollView.contentOffset.y > CGFloat((currentIndex - startIndex)) * UIScreen.height + UIScreen.height / 2 {
                scrollAtIndex(index + startIndex)
            }

        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 获取当前可见的第一个 item 的索引
        let index = (Int)(scrollView.contentOffset.y / UIScreen.height)

        if scrollView.contentOffset.y < CGFloat((currentIndex - startIndex)) * UIScreen.height - UIScreen.height / 2 ||
            scrollView.contentOffset.y > CGFloat((currentIndex - startIndex)) * UIScreen.height + UIScreen.height / 2 {
            scrollAtIndex(index + startIndex)
        }
    }

}



