//
//  MeOtherTableViewCell.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/20.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

let meOtherCellIdent = "meOtherCellIdent"
class MeOtherTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle,
                  reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        self.textLabel?.font = UIFont.systemFont(ofSize: 15)
        self.textLabel?.textColor = UIColor.black
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.size(25, height: 25).centerY(self.height * 0.5)
        self.textLabel?.x((self.imageView?.rightX)! + 10).centerY(self.height * 0.5)
    }

}
