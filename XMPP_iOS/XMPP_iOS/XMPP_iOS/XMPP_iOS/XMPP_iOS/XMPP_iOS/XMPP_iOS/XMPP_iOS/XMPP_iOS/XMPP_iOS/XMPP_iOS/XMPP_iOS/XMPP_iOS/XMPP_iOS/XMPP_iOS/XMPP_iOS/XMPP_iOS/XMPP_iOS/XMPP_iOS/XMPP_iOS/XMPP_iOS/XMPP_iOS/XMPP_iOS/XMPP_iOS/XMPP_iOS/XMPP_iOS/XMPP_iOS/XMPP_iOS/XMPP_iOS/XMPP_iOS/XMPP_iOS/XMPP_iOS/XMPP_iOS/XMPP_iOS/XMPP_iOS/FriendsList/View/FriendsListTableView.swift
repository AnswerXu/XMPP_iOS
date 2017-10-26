//
//  FriendsListTableView.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/12.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit
import XMPPFramework

class FriendsListTableView: UITableView {
    
    lazy var listDatas : [Any] = {
        return [Any]()
    }()

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        self.register(FriendsListTableViewCell.self, forCellReuseIdentifier: FriendsListTableViewCellIdent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK:- UITableViewDataSource
extension FriendsListTableView : UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return listDatas.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FriendsListTableViewCell.dequeueReusableCell(withTableView: tableView)
        if let object = listDatas[indexPath.row] as? XMPPUserCoreDataStorageObject {
             cell?.fillCell(withUserCoreDataStorageObject: object)
        }
        return cell!
    }
}

// MARK:- UITableViewDelegate
extension FriendsListTableView : UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 0.000001
    }
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        // 跳转到聊天界面
        if let vc_self = self.viewController_self() {
            let chatVC = ChatViewController.init()
            chatVC.userCoreDataStorageObject = self.listDatas[indexPath.row] as? XMPPUserCoreDataStorageObject
            chatVC.hidesBottomBarWhenPushed = true
            vc_self.navigationController?.pushViewController(chatVC, animated: true)
        }
    }
}
