//
//  XTCircleCollectionViewTestVC.swift
//  XTAnimations
//
//  Created by summerxx on 2024/12/5.
//  Copyright © 2024 夏天然后. All rights reserved.
//
import UIKit

class Horizontal3DLayout: UICollectionViewFlowLayout {

    // 调整视差效果的缩放比例
    var scaleFactor: CGFloat = 0.31
    var maxScale: CGFloat = 1.0
    var minScale: CGFloat = 0.7

    override func prepare(forCollectionViewUpdates: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: forCollectionViewUpdates)
    }

    // 设置 cell 的布局
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    // 在滚动时动态调整 cell 的缩放
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }

        let collectionViewCenterX = collectionView!.contentOffset.x + collectionView!.bounds.size.width / 2

        for attribute in attributes {
            let distance = abs(collectionViewCenterX - attribute.center.x)
            let scale = 1 - min(distance / (collectionView!.bounds.size.width / 2), 1) * scaleFactor
            attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
            attribute.zIndex = Int(scale * 1000)  // 更大 scale 的 cell 置顶
        }

        return attributes
    }
}

class XTCircleCollectionViewTestVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化 collectionView
        let layout = Horizontal3DLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 200, width: UIScreen.width, height: 320), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        self.view.addSubview(collectionView)

        self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
    }

    // 数据源方法
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20 // 你的数据量
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)

        cell.backgroundColor = .systemBlue
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true

        return cell
    }

    // 设置每个 cell 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300) // 你可以根据需求调整尺寸
    }
}
