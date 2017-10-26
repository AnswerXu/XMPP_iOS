//
//  ChatViewController.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/16.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit
import XMPPFramework

class ChatViewController: UIViewController {

    var userCoreDataStorageObject : XMPPUserCoreDataStorageObject?
    
    fileprivate lazy var tableView : ChatTableView = {
        let tableView = ChatTableView.init(frame: self.view.bounds, style: .plain)
        return tableView
    }()
    
    deinit {
        // 销毁观察者
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        
        // 监听好友列表变化
        NotificationCenter.default.addObserver(self, selector: #selector(reloadChatRecords), name: NSNotification.Name(rawValue: notificationName_chatRecordsDidChange), object: nil)
        
        reloadChatRecords()
    }
    
    // 好友列表发生变化的监听方法
    @objc private func reloadChatRecords() {
        // 获取好友列表信息数组
        guard let object = userCoreDataStorageObject else { return }
        guard let chatRecordsArray = XMPPManager.manager.getChatRecords(withFriendName: object.displayName) else {
            return
        }
//        print(chatRecordsArray)
        // 刷新好友列表
        tableView.dataArray = chatRecordsArray
        tableView.reloadData()
    }
}
