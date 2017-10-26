//
//  AddFriendsViewController.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/18.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

class AddFriendsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "添加朋友"
        self.tableView.register(AddFriendsTableViewCell.self, forCellReuseIdentifier: addFriendsCellIdent)
    }
}

extension AddFriendsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: addFriendsCellIdent) as? AddFriendsTableViewCell
        cell?.imageView?.image = [#imageLiteral(resourceName: "add_friend_icon_reda"),#imageLiteral(resourceName: "add_friend_icon_addgroup"),#imageLiteral(resourceName: "add_friend_icon_scanqr"),#imageLiteral(resourceName: "add_friend_icon_contacts"),#imageLiteral(resourceName: "add_friend_icon_offical")][indexPath.row]
        cell?.textLabel?.text = ["雷达加朋友","面对面建群","扫一扫","手机联系人","公众号"][indexPath.row]
        cell?.detailTextLabel?.text = ["添加身边的朋友","与身边的朋友进入同一个群聊","扫描二维码名片","添加通讯录中的朋友","获取更多的资讯和服务"][indexPath.row]
        return cell!
    }
}
