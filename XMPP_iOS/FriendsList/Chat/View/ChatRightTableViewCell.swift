//
//  ChatRightTableViewCell.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/16.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

let chatRightCellIdent = "chatRightCellIdent"
class ChatRightTableViewCell: ChatLeftTableViewCell {
    
    class func dequeueReusableRightCell(withTableView tableView: UITableView)  -> ChatRightTableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: chatRightCellIdent) as? ChatRightTableViewCell
        
        return cell
    }
    
    override init(style: UITableViewCellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.bgImageView.image = UIImage.init(named: "SenderTextNodeBkg")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layout() {
        self.iconImageView.x(ScreenW - 40).width(30).height(30).y(10)
        self.bgImageView.x(ScreenW - 45 - (self.messageSize.width + 30)).y(self.iconImageView.y).width(self.messageSize.width + 30).height(self.messageSize.height + 20)
        self.messageLabel.x(10).y(5).width(self.messageSize.width + 5).height(self.messageSize.height + 5)
    }
}
