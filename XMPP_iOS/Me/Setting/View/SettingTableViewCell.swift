//
//  SettingTableViewCell.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/23.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

let settingCellIdent = "settingCellIdent"
class SettingTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.font = UIFont.systemFont(ofSize: 15)
        self.textLabel?.textColor = UIColor.black
        self.selectionStyle = .none
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.x(10).centerY(self.height * 0.5)
    }
}
