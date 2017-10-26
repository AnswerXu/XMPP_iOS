//
//  AddFriendsTableViewCell.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/18.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

let addFriendsCellIdent = "addFriendsCellIdent"
class AddFriendsTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle,
                  reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.textLabel?.font = UIFont.systemFont(ofSize: 14)
        self.textLabel?.textColor = UIColor.black
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        self.detailTextLabel?.textColor = UIColor.lightGray
        self.accessoryType = .disclosureIndicator
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(10)
            make.width.height.equalTo(30)
            make.centerY.equalTo(self.height * 0.5)
        })
        self.textLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.imageView?.snp.right)!).offset(10)
            make.top.equalTo(self.imageView!)
        })
        self.detailTextLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.textLabel!)
            make.bottom.equalTo(self.imageView!)
        })
    }

}
