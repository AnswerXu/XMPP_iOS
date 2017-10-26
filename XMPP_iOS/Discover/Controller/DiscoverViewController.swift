//
//  DiscoverViewController.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/16.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    
    private lazy var dataSource : [[DiscoverModel]] = {
        var dataSource = [[DiscoverModel]]()
        let imageNameArray = [["ff_IconShowAlbum"],["ff_IconQRCode","ff_IconShake"],["ff_IconLocationService","ff_IconBottle"],["CreditCard_ShoppingBag","Userguide_Gamecenter_icon"]]
        let titleArray = [["朋友圈"],["扫一扫","摇一摇"],["附近的人","漂流瓶"],["购物","游戏"]]
        for section in 0..<titleArray.count {
            var sectionModels = [DiscoverModel]()
            for row in 0..<titleArray[section].count {
                let dict = ["imageName" : imageNameArray[section][row], "text" : titleArray[section][row]]
                let model = DiscoverModel.init(dict: dict)
                sectionModels.append(model)
            }
            dataSource.append(sectionModels)
        }
        return dataSource
    }()
    
    private lazy var tableView : DiscoverTableView = {
        let tableView = DiscoverTableView.tableView(frame: self.view.bounds)
        tableView.dataModels = self.dataSource
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
    }
}
