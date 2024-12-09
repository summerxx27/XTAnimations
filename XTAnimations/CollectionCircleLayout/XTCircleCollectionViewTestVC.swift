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
            var transform = CGAffineTransform.identity
            transform.tx = -CGFloat(attribute.indexPath.item) * attribute.size.width + (collectionView?.bounds.width ?? 0) / 2 - attribute.size.width / 2
            attribute.transform = transform
        }

        return attributes
    }


}

class XTCircleCollectionViewTestVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionView: UICollectionView!

    private var lastTranslation: CGPoint = .zero

    var timer: Timer?

    var coutt: Int = 0

    var lastDeltaX = 0

    var awareView = EllipticalRotatingImagesDepthAwareView()

    override func viewDidLoad() {
        super.viewDidLoad()

//        // 初始化 collectionView
//        let layout = Horizontal3DLayout()
//        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 50, height: 200)
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
//        collectionView = UICollectionView(frame: CGRect(x: 0, y: 200, width: UIScreen.width, height: 320), collectionViewLayout: layout)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
//
//        self.view.addSubview(collectionView)
//
//        self.collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)


        self.view += awareView
        awareView.backgroundColor = .cyan
        awareView.frame = CGRect(x: 0, y: 200, width: UIScreen.width, height: 300)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)


        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panAction))
        awareView.addGestureRecognizer(pan)


        let testView = UIView()
        view += testView
        testView.frame = CGRect(0, 500, 100, 100)
        testView.backgroundColor = .yellow

        let angle = CGFloat(30 * Double.pi / 180) // 将 30 度转换为弧度
        var transform = CATransform3DIdentity // 初始 Transform
        transform.m34 = -1.0 / 500.0 // 设置透视效果
        transform = CATransform3DRotate(transform, angle, 0, 1, 0) // 绕 Y 轴旋转
        testView.layer.transform = transform
    }

    @objc func updateCountdown() {
        coutt += 13
//        awareView.rotationAngle = CGFloat(coutt)
    }

    var lastAngle = 0.0

    @objc func panAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.awareView)

        // 获取拖动的增量
        let deltaX = translation.x - lastTranslation.x
        let newX = deltaX / 10 + lastAngle

        if newX > 360 {
            lastAngle = newX - 360
        } else if newX < 0 {
            lastAngle = 360 + newX
        } else {
            lastAngle = newX
        }
        awareView.rotationAngle = -lastAngle

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
}
