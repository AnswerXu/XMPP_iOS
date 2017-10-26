//
//  MeViewController.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/16.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {
    
    private lazy var dataSource : [[MeModel]] = {
        var dataSource = [[MeModel]]()
        let imageNameArray = [["userIcon"],["MoreMyBankCard"],["MoreMyFavorites","MoreMyAlbum","MyCardPackageIcon","MoreExpressionShops"],["MoreSetting"]]
        let titleArray = [[XMPPManager.manager.xmppJID?.user ?? ""],["钱包"],["收藏","相册","卡包","表情"],["设置"]]
        for section in 0..<titleArray.count {
            var sectionModels = [MeModel]()
            for row in 0..<titleArray[section].count {
                let dict = ["imageName" : imageNameArray[section][row], "text" : titleArray[section][row]]
                let model = MeModel.init(dict: dict)
                sectionModels.append(model)
            }
            dataSource.append(sectionModels)
        }
        return dataSource
    }()
    
    private lazy var tableView : MeTableView = {
        let tableView = MeTableView.tableView(frame: self.view.bounds)
        tableView.dataModels = self.dataSource
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
    }
}
