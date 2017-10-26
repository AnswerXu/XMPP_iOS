//
//  NewFriendsViewController.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/20.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

class NewFriendsViewController: UIViewController {
    
    private lazy var tableView : NewFriendsTableView = {
        let tableView = NewFriendsTableView.tableView(frame: self.view.bounds)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "新的朋友"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "添加朋友", style: .done, target: self, action: #selector(rightBarButtonItemAction))
        self.view.addSubview(self.tableView)
    }
    
    @objc private func rightBarButtonItemAction() {
        // 添加朋友
        let addFriendsVC = AddFriendsViewController.init()
        self.navigationController?.pushViewController(addFriendsVC, animated: true)
    }

}
