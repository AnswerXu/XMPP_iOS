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
    
    var indexPath : IndexPath?
    
    lazy var iconImageView : UIImageView = {
        let imageView = UIImageView.init()
        return imageView
    }()
    
    lazy var bgImageView : UIImageView = {
        let imageView = UIImageView.init(image: UIImage.init(named: "ReceiverTextNodeBkg"))
        return imageView
    }()
    
    lazy var messageLabel : UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.darkText
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    var messageSize : CGSize = .zero
    
    class func dequeueReusableLeftCell(withTableView tableView: UITableView)  -> ChatLeftTableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: chatLeftCellIdent) as? ChatLeftTableViewCell
        
        return cell
    }
    
    public func fillCell(withModel model: ChatModel?) {
        guard let model = model else { return }
        self.iconImageView.image = model.iconImage
        self.messageLabel.text = model.coreDataObject?.body
        self.messageLabel.sizeToFit()
        self.messageSize = model.messageSize
    }

    override init(style: UITableViewCellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(bgImageView)
        self.bgImageView.addSubview(messageLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout() {
        self.iconImageView.x(10).width(30).height(30).y(10)
        self.bgImageView.x(self.iconImageView.rightX + 5).y(self.iconImageView.y + 5).width(self.messageSize.width + 30).height(self.messageSize.height + 20)
        self.messageLabel.x(15).y(5).width(self.messageSize.width + 5).height(self.messageSize.height + 5)
    }
}
