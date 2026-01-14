//
//  HeroTestViewController.swift
//  XTAnimations
//
//  Created by summerxx on 2023/5/30.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit

class HeroTestViewController: UIViewController {
    let contentView = UIView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.hero.navigationAnimationType = .push(direction: .down)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        hero.isEnabled = true

        view.backgroundColor = .white
        view.addSubview(contentView)

        contentView.backgroundColor = .yellow
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView += button
        button.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.leading.equalTo(10)
            make.width.height.equalTo(40)
        }
    }

    private lazy var button = UIButton().then {
        $0.setTitle("Test", for: .normal)
        $0.backgroundColor = .red
        $0.addTarget(self, action: #selector(click), for: .touchUpInside)
    }

    @objc
    func click() {
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
}
