//
//  NewFriendsTableView.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/20.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

class NewFriendsTableView: UITableView {
    
    var newFriendsList : [Any]?
    
    class func tableView(frame: CGRect) -> NewFriendsTableView {
        let tableView = NewFriendsTableView.init(frame: frame, style: .plain)
        tableView.dataSource = tableView
        tableView.delegate = tableView
        tableView.register(NewFriendsSection1TableViewCell.self, forCellReuseIdentifier: newFriendsSection1CellIdent)
        tableView.register(NewFriendsSection2TableViewCell.self, forCellReuseIdentifier: newFriendsSection2CellIdent)
        return tableView
    }
}

// MARK:- UITableViewDataSource
extension NewFriendsTableView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        return self.newFriendsList?.count ?? 0
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = NewFriendsSection1TableViewCell.dequeueReusableCell(withTableView: tableView)
            return cell!
        }
        let cell = NewFriendsSection2TableViewCell.dequeueReusableCell(withTableView: tableView)
        
        return cell!
    }
}

// MARK:- UITableViewDelegate
extension NewFriendsTableView : UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return [80,44][indexPath.section]
    }
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return [10,20][section]
    }
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            print("添加手机联系人")
        }
    }
}
