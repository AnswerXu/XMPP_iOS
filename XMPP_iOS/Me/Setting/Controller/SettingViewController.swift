//
//  SettingViewController.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/23.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit
import XMPPFramework

class SettingViewController: UIViewController {
    
    private lazy var datasArray : [[String]] = {
        let array = [["账号与安全"],["新消息与通知","隐私","通用"],["帮助与反馈","关于微信"],["插件"],["退出登录"]]
        return array
    }()

    private lazy var tableView : SettingTableView = {
        let tableView = SettingTableView.tableView(frame: self.view.bounds)
        tableView.datasArray = self.datasArray
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.tableView)
        XMPPManager.manager.xmppStream?.addDelegate(self, delegateQueue: DispatchQueue.main)
    }
}

extension SettingViewController : XMPPStreamDelegate {
    func xmppStreamDidDisconnect(_ sender: XMPPStream!,
                                 withError error: Error!) {
        // 退出登录状态成功
        ChooseRootControllerHelper.helper.saveLoginMark(withState: false)
        ChooseRootControllerHelper.helper.chooseRootController()
    }
}
