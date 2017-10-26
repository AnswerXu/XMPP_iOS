//
//  NewFriendsSection1TableViewCell.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/20.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

let newFriendsSection1CellIdent = "newFriendsSection1CellIdent"
class NewFriendsSection1TableViewCell: UITableViewCell {

    class func dequeueReusableCell(withTableView tableView: UITableView)  -> NewFriendsSection1TableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: newFriendsSection1CellIdent) as? NewFriendsSection1TableViewCell
        return cell
    }
    
    override init(style: UITableViewCellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        textLabel?.font = UIFont.systemFont(ofSize: 12)
        textLabel?.textColor = UIColor.lightGray
        imageView?.image = #imageLiteral(resourceName: "tabbar_meHL")
        textLabel?.text = "添加手机联系人"
        textLabel?.textAlignment = .center
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.centerX(self.width * 0.5).y(15)
        self.textLabel?.width(200).height(12).centerX(self.width * 0.5).y((self.imageView?.bottomY)! + 10)
    }
}
