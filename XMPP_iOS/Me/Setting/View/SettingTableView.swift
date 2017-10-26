//
//  SettingTableView.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/23.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

class SettingTableView: UITableView {
    
    var datasArray : [[String]]?

    class func tableView(frame: CGRect) -> SettingTableView {
        let tableView = SettingTableView.init(frame: frame, style: .grouped)
        return tableView
    }
    
    override init(frame: CGRect,
                  style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.separatorInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        self.dataSource = self
        self.delegate = self
        self.register(SettingTableViewCell.self,
                      forCellReuseIdentifier: settingCellIdent)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SettingTableView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return datasArray?.count ?? 0
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return datasArray?[section].count ?? 0
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: settingCellIdent)
        if indexPath.section == (datasArray?.count ?? 0) - 1 {
            cell?.accessoryType = .none
            cell?.textLabel?.textAlignment = .center
        }else{
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.textAlignment = .left
        }
        cell?.textLabel?.text = datasArray?[indexPath.section][indexPath.row]
        return cell!
    }
}

extension SettingTableView : UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        case 3:
            break
        case 4:
            // 退出登录
            XMPPManager.manager.exitLogin()
            break
        default: break
        }
    }
}

