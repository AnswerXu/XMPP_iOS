//
//  FriendsListViewController.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/12.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit
import XMPPFramework

class FriendsListViewController: UIViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    lazy var tableView : FriendsListTableView = {
        let tableView = FriendsListTableView.init(frame: self.view.bounds, style: .grouped)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        
        // 监听好友列表变化
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFriendList), name: NSNotification.Name(rawValue: notificationName_friendsListDidChange), object: nil)
        
        reloadFriendList()
    }
    
    // 好友列表发生变化的监听方法
    @objc private func reloadFriendList() {
        // 获取好友列表信息数组
        guard let friendListArray = XMPPManager.manager.getFriendsList() else {
            return
        }
        // 刷新好友列表
        tableView.listDatas = friendListArray
        tableView.reloadData()
    }
}

