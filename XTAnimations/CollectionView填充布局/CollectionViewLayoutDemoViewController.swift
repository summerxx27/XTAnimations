//
//  CollectionViewLayoutDemoViewController.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/18.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit
import SnapKit

class CollectionViewLayoutDemoViewController: UIViewController {

    /// 测试
    //    let count = Int(arc4random()) % (16 - 2 + 1) + 2
    var count = 5

    /// 间隔
    static let spaceing = 2.0

    /// 大的方块宽
    let bigW = (UIScreen.width - 6) / 2

    /// 小的方块宽
    let smallW = (UIScreen.width - 10) / 4

    private lazy var timer = Timer(timeInterval: 3,
                                   target: self,
                                   selector: #selector(start),
                                   userInfo: nil,
                                   repeats: true)

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    deinit {
        timer.invalidate()
    }

    lazy var collectionView: UICollectionView = {
        let layout = ZLCollectionViewVerticalLayout()
        layout.delegate = self
        layout.canDrag = false
        layout.isFloor = false
        layout.minimumLineSpacing = CollectionViewLayoutDemoViewController.spaceing
        layout.minimumInteritemSpacing = CollectionViewLayoutDemoViewController.spaceing
        layout.sectionInset = UIEdgeInsets.only(left: CollectionViewLayoutDemoViewController.spaceing, right: CollectionViewLayoutDemoViewController.spaceing)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .black
        view.semanticContentAttribute = .forceLeftToRight
        view.dataSource = self
        view.delegate = self
        view.registerCell(UICollectionViewCell.self)
        return view
    }()
}

// MARK: - Private UI
private extension CollectionViewLayoutDemoViewController {

    func configUI() {
        view.backgroundColor = .blue
        view += collectionView
        collectionView.snp.makeConstraints {
            $0.left.right.equalTo(0)
            $0.top.equalTo(100)
            $0.height.equalTo(bigW * 2 + 2)
        }

        RunLoop.main.add(timer, forMode: .common)
        timer.fire()


//        self.collectionView.reloadData()

        /// 这里需要加回到主线程, 不加可能导致布局错误
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//            print("Current thread1: \(Thread.current)")
//        }
        
    }
}

// MARK: - Test Code
extension CollectionViewLayoutDemoViewController {

    @objc func start() {
        self.count = Int(arc4random()) % (16 - 5 + 1) + 2

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001) {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSourc
extension CollectionViewLayoutDemoViewController: UICollectionViewDelegate, UICollectionViewDataSource, ZLCollectionViewBaseFlowLayoutDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(UICollectionViewCell.self, for: indexPath).then {
            $0.backgroundColor = UIColor.randomColor
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("itwm == \(indexPath.item)")
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        /// TODO: 一个的时候应该需要特殊处理, 暂时先放着
        if count == 1 {
            return CGSize(UIScreen.width, UIScreen.width)
        }

        if count == 2 {
            return CGSize(bigW, bigW * 2 + CollectionViewLayoutDemoViewController.spaceing)
        }

        if count == 3 {
            switch indexPath.item {
            case 0:
                return CGSize(bigW, bigW * 2 + CollectionViewLayoutDemoViewController.spaceing)
            default:
                return CGSize(bigW, bigW)
            }

        }

        if count == 4 {
            return CGSize(bigW, bigW)
        }

        if count == 5 || count == 6 || count == 7 {
            switch indexPath.item {
            case 0, 1, 2:
                return CGSize(bigW, bigW)
            default:
                return CGSize(smallW, smallW)
            }
        }

        if count == 8 || count == 9 || count == 10 {
            switch indexPath.item {
            case 0, 1:
                return CGSize(bigW, bigW)
            default:
                return CGSize(smallW, smallW)
            }
        }

        if count == 11 || count == 12 || count == 13 {
            switch indexPath.item {
            case 0:
                return CGSize(bigW, bigW)
            default:
                return CGSize(smallW, smallW)
            }
        }

        if count == 14 || count == 15 || count == 16 {
            return CGSize(smallW, smallW)
        }

        return .zero
    }
}

