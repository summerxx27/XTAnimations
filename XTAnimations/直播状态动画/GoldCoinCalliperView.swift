//
//  GoldCoinCalliperView.swift
//  XTAnimations
//
//  Created by summerxx on 2023/11/17.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit
import SnapKit

/// 金币打赏卡尺
class GoldCoinCalliperView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configUI() {
        self += collectionView

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.autoScrollToItem(at: 5)
        }
    }

    private func layout() {
        collectionView.snp.makeConstraints { make in
            make.leading.equalTo(19)
            make.trailing.equalTo(-19)
            make.height.equalTo(64)
        }
    }

    private lazy var generator = UINotificationFeedbackGenerator()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(2, 60)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .black.withAlphaComponent(0.8)
        view.semanticContentAttribute = .forceLeftToRight
        view.dataSource = self
        view.delegate = self
        view.registerCell(GoldCoinCalliperViewCell.self)
        return view
    }()
}

extension GoldCoinCalliperView {
    func autoScrollToItem(at index: Int) {
        // 要滚动到的单元格的索引路径
        // TODO: Zac
        // 根据分值计算一个合适 Item
        let indexPathToScrollTo = IndexPath(item: index, section: 0)
        // 滚动到指定的单元格
        collectionView.scrollToItem(at: indexPathToScrollTo, at: .left, animated: true)
    }
}

extension GoldCoinCalliperView: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 500
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(GoldCoinCalliperViewCell.self, for: indexPath).then {
            $0.isSmall = !(indexPath.item % 5 == 0) && indexPath.item != 0
            if (indexPath.item % 5 == 0) {
                generator.notificationOccurred(.success)
            }
        }
    }
}


class GoldCoinCalliperViewCell: UICollectionViewCell {

    var isSmall: Bool = false {
        didSet {
            bigScale.isHidden = isSmall
            smallScale.isHidden = !isSmall
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        layout()
    }

    private func configUI() {

        self += [
            smallScale,
            bigScale
        ]
    }

    private func layout() {
        smallScale.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(1, 8))
        }

        bigScale.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(2, 24))
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var smallScale = UIView().then {
        $0.backgroundColor = .white.withAlphaComponent(0.5)
        $0.layer.cornerRadius = 0.5
        $0.clipsToBounds = true
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 1.5
        $0.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        $0.isHidden = true
    }

    private lazy var bigScale = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 1
        $0.clipsToBounds = true
        $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowRadius = 1.5
        $0.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        $0.isHidden = true
    }
}
