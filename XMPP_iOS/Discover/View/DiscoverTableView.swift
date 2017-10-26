//
//  DiscoverTableView.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/20.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

class DiscoverTableView: UITableView {
    
    var dataModels : [[DiscoverModel]]?

    class func tableView(frame: CGRect) -> DiscoverTableView {
        let tableView = DiscoverTableView.init(frame: frame, style: .grouped)
        return tableView
    }
    override init(frame: CGRect,
                  style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.separatorInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        self.dataSource = self
        self.delegate = self
        self.register(DiscoverTableViewCell.self, forCellReuseIdentifier: discoverCellIdent)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension DiscoverTableView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataModels?.count ?? 0
    }
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return dataModels?[section].count ?? 0
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: discoverCellIdent)
        if let model = dataModels?[indexPath.section][indexPath.row] {
            cell?.imageView?.image = model.image
            cell?.textLabel?.text = model.text
        }
        return cell!
    }
}

extension DiscoverTableView : UITableViewDelegate {
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
}
