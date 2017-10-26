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
        self.separatorInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        self.register(FriendsListTableViewCell.self, forCellReuseIdentifier: FriendsListTableViewCellIdent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK:- UITableViewDataSource
extension FriendsListTableView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        return listDatas.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = FriendsListTableViewCell.dequeueReusableCell(withTableView: tableView)
            cell?.imageView?.image = [#imageLiteral(resourceName: "plugins_FriendNotify"),#imageLiteral(resourceName: "add_friend_icon_addgroup"),#imageLiteral(resourceName: "Contact_icon_ContactTag"),#imageLiteral(resourceName: "add_friend_icon_offical")][indexPath.row]
            cell?.textLabel?.text = ["新的朋友","群聊","标签","公众号"][indexPath.row]
            return cell!
        }
        
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
        return 44
    }
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return [0.000001, 10.0][section]
    }
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        guard let vc_self = self.viewController_self() else { return }
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                // 新的朋友
                let newFriendsVC = NewFriendsViewController.init()
                newFriendsVC.hidesBottomBarWhenPushed = true
                vc_self.navigationController?.pushViewController(newFriendsVC, animated: true)
                break
            case 1:
                // 群聊
                break
            case 2:
                // 标签
                break
            case 3:
                // 公众号
                break
            default: break
            }
        }else{
            // 跳转到聊天界面
            let chatVC = ChatViewController.init()
            chatVC.userCoreDataStorageObject = self.listDatas[indexPath.row] as? XMPPUserCoreDataStorageObject
            chatVC.hidesBottomBarWhenPushed = true
            vc_self.navigationController?.pushViewController(chatVC, animated: true)
        }
    }
}
