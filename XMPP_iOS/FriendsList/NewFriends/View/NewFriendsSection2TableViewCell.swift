//
//  NewFriendsTableViewCell.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/20.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

let newFriendsSection2CellIdent = "newFriendsSection2CellIdent"
class NewFriendsSection2TableViewCell: FriendsListTableViewCell {
    
    override class func dequeueReusableCell(withTableView tableView: UITableView)  -> NewFriendsSection2TableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: newFriendsSection2CellIdent) as? NewFriendsSection2TableViewCell
        
        return cell
    }

    
    private lazy var addItem : UIButton = {
        let item = UIButton.init(type: .custom)
        item.setTitle("添加", for: .normal)
        item.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        item.setTitleColor(UIColor.black, for: .normal)
        item.layer.cornerRadius = 5
        item.layer.borderColor = UIColor.lightGray.cgColor
        item.layer.borderWidth = 0.5
        item.backgroundColor = UIColor.hexColorWith(hexVale: 0xf5f5f5)
        return item
    }()

    override init(style: UITableViewCellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        self.detailTextLabel?.textColor = UIColor.lightGray
        self.contentView.addSubview(addItem)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layout() {
        self.imageView?.x(10).height(30).width(30).centerY(self.height * 0.5)
        self.textLabel?.x((self.imageView?.rightX)! + 10).y((self.imageView?.y)!)
        self.detailTextLabel?.x((self.textLabel?.x)!).y((self.textLabel?.bottomY)! + 10)
        addItem.size(40, height: 20).rightX(20).centerY(self.height * 0.5)
    }
}
