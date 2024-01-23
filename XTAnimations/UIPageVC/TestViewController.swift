//
//  TestViewController.swift
//  XTAnimations
//
//  Created by summerxx on 2023/3/29.
//  Copyright © 2023 夏天然后. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        addRefreshHeader()
    }

    func addRefreshHeader() {
          MJRefreshNormalHeader { [weak self] in
            // load some data
          }.autoChangeTransparency(true)
          .link(to: tableView)
      }

    private func setupViews() {
        view.backgroundColor = UIColor(0x111111)
        view += tableView

        tableView.snp.makeConstraints {
            $0.left.equalTo(0)
            $0.top.equalTo(0)
            $0.size.equalTo(CGSize(UIScreen.width, 200))
        }
    }

    lazy var tableView = UITableView().then {
        $0.backgroundColor = .white
        $0.delegate = self
        $0.dataSource = self
        $0.rowHeight = 64
        $0.isExclusiveTouch = true
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.registerCell(UITableViewCell.self)
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.separatorStyle = .none
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)
        cell.backgroundColor = UIColor.randomColor
        return cell
    }
}

