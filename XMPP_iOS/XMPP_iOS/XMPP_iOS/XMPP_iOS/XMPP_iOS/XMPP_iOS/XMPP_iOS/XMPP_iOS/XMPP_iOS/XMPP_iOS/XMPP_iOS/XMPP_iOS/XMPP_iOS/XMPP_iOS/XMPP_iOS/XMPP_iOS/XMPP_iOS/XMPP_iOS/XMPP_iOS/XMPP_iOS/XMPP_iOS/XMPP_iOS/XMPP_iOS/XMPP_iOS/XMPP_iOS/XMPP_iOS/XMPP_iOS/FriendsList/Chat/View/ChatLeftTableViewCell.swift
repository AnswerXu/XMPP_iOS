//
//  ChatLeftTableViewCell.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/16.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit
import SnapKit

let chatLeftCellIdent = "chatLeftCellIdent"

class ChatLeftTableViewCell: UITableViewCell {
    
    private lazy var iconImageView : UIImageView = {
        let imageView = UIImageView.init()
        return imageView
    }()
    
    private lazy var bgImageView : UIImageView = {
        let imageView = UIImageView.init(image: UIImage.init(named: "ReceiverTextNodeBkg"))
        return imageView
    }()
    
    private lazy var messageLabel : UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.darkText
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var messageSize : CGSize = .zero
    
    class func dequeueReusableLeftCell(withTableView tableView: UITableView)  -> ChatLeftTableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: chatLeftCellIdent) as? ChatLeftTableViewCell
        
        return cell
    }
    
    public func fillCell(withIconImage icon: UIImage?, message: String?) {
        self.iconImageView.image = icon
        self.messageLabel.text = message
        self.messageSize = self.messageLabel.sizeThatFits(CGSize.init(width: self.width - 55, height: CGFloat(MAXFLOAT)))
    }

    override init(style: UITableViewCellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(bgImageView)
        self.contentView.addSubview(messageLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.iconImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(10)
            make.width.height.equalTo(30)
        }
        
        self.bgImageView.snp.makeConstraints({ (make) in
            make.left.equalTo(self.iconImageView.snp.right).offset(5)
            make.top.equalTo(self.iconImageView.snp.top)
            make.width.equalTo(self.messageSize.width + 30)
            make.height.equalTo(self.messageSize.height + 20)
        })
        
        self.messageLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.bgImageView).offset(20)
            make.top.equalTo(self.bgImageView).offset(10)
            make.right.bottom.equalTo(self.bgImageView).offset(-10)
        }
    }
}
