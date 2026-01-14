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
//    var count = Int(arc4random()) % (16 - 2 + 1) + 2
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
//        layout.layoutType = .init(6)
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

//        RunLoop.main.add(timer, forMode: .common)
//        timer.fire()


        self.collectionView.reloadData()

        // 这里需要加回到主线程, 不加可能导致布局错误
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            print("Current thread1: \(Thread.current)")
        }
        
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

//extension CollectionViewLayoutDemoViewController: ZLCollectionViewBaseFlowLayoutDelegate {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, typeOfLayout section: Int) -> ZLLayoutType {
//        return ZLLayoutType.init(rawValue: 6)
//    }
//}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSourc
extension CollectionViewLayoutDemoViewController: UICollectionViewDelegate, UICollectionViewDataSource, ZLCollectionViewBaseFlowLayoutDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, typeOfLayout section: Int) -> ZLLayoutType {
        return ZLLayoutType.init(rawValue: 6)
    }

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

        guard let selectedCell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        cellTapped(cell: selectedCell.contentView, data: indexPath.item)
    }

    func cellTapped(cell: UIView, data: Int) {
        debugPrint("\(data)")
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        /// TODO: 一个的时候应该需要特殊处理, 暂时先放着
//        if count == 1 {
//            return CGSize(UIScreen.width, UIScreen.width)
//        }
//
//        if count == 2 {
//            return CGSize(bigW, bigW * 2 + CollectionViewLayoutDemoViewController.spaceing)
//        }
//
//        if count == 3 {
//            switch indexPath.item {
//            case 0:
//                return CGSize(bigW, bigW * 2 + CollectionViewLayoutDemoViewController.spaceing)
//            default:
//                return CGSize(bigW, bigW)
//            }
//
//        }
//
//        if count == 4 {
//            return CGSize(bigW, bigW)
//        }
//
//        if count == 5 || count == 6 || count == 7 {
//            switch indexPath.item {
//            case 0, 1, 2:
//                return CGSize(bigW, bigW)
//            default:
//                return CGSize(smallW, smallW)
//            }
//        }
//
//        if count == 8 || count == 9 || count == 10 {
//            switch indexPath.item {
//            case 0, 1:
//                return CGSize(bigW, bigW)
//            default:
//                return CGSize(smallW, smallW)
//            }
//        }
//
//        if count == 11 || count == 12 || count == 13 {
//            switch indexPath.item {
//            case 0:
//                return CGSize(bigW, bigW)
//            default:
//                return CGSize(smallW, smallW)
//            }
//        }
//
//        if count == 14 || count == 15 || count == 16 {
//            return CGSize(smallW, smallW)
//        }
//
//        return CGSize(bigW, bigW)
//    }


    //如果是绝对定位布局必须是否该代理，设置每个item的frame
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, rectOfItem indexPath: IndexPath) -> CGRect {
        let width = (collectionView.frame.size.width - 200) / 3
        let height = width
        let space = 10.0
        switch indexPath.item {
        case 0:
            return CGRect(x: 0, y: 0, width: 200, height: 400)
        case 1:
            return CGRect(x: 220, y: space, width: width , height: height)
        case 2:
            return CGRect(x: 240, y: height + space * (2), width: width, height: height)
        case 3:
            return CGRect(x: 260, y: height * (3 - 1) + space * (3), width: width, height: height)
        case 4:
            return CGRect(x: 280, y: height * (4 - 1) + space * (4), width: width, height: height)
        default:
            return .zero
        }
    }
}

