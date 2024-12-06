//
//  ImageCollectionViewCell.swift
//  XTAnimations
//
//  Created by summerxx on 2024/12/6.
//  Copyright © 2024 夏天然后. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    static let identifier = "ImageCell"

    private var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView = UIImageView(frame: self.bounds)
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(image: UIImage) {
        imageView.image = image
    }
}
