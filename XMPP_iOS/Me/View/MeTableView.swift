//
//  MeTableView.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/20.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

class MeTableView: UITableView {
    
    var dataModels : [[MeModel]]?

    class func tableView(frame: CGRect) -> MeTableView {
        let tableView = MeTableView.init(frame: frame, style: .grouped)
        return tableView
    }
    
    override init(frame: CGRect,
                  style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        self.register(MeSection0TableViewCell.self, forCellReuseIdentifier: meSection0CellIdent)
        self.register(MeOtherTableViewCell.self, forCellReuseIdentifier: meOtherCellIdent)
        self.separatorInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}

extension MeTableView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataModels?.count ?? 0
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return dataModels?[section].count ?? 0
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: meSection0CellIdent)
            if let model = dataModels?[indexPath.section][indexPath.row] {
                cell?.imageView?.image = model.image
                cell?.textLabel?.text = model.text
                cell?.detailTextLabel?.text = "微信号：AnswerXu"
            }
            return cell!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: meOtherCellIdent)
        if let model = dataModels?[indexPath.section][indexPath.row] {
            cell?.imageView?.image = model.image
            cell?.textLabel?.text = model.text
        }
        return cell!
    }
}

extension MeTableView : UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 80 : 44
    }
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        guard let vc_self = self.viewController_self() else { return }
        switch indexPath.section {
            case 0:
                
                break
            case 1:
                
                break
            case 2:
                
                break
            case 3:
                // 设置
                let settingVC = SettingViewController.init()
                settingVC.hidesBottomBarWhenPushed = true
                vc_self.navigationController?.pushViewController(settingVC, animated: true)
                break
        default: break
        }
        
    }
}
