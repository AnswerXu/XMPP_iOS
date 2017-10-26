//
//  ChatRightTableViewCell.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/16.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

let chatRightCellIdent = "chatRightCellIdent"
class ChatRightTableViewCell: UITableViewCell {
    
    class func dequeueReusableRightCell(withTableView tableView: UITableView)  -> ChatRightTableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: chatRightCellIdent) as? ChatRightTableViewCell
        
        return cell
    }

    override init(style: UITableViewCellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
