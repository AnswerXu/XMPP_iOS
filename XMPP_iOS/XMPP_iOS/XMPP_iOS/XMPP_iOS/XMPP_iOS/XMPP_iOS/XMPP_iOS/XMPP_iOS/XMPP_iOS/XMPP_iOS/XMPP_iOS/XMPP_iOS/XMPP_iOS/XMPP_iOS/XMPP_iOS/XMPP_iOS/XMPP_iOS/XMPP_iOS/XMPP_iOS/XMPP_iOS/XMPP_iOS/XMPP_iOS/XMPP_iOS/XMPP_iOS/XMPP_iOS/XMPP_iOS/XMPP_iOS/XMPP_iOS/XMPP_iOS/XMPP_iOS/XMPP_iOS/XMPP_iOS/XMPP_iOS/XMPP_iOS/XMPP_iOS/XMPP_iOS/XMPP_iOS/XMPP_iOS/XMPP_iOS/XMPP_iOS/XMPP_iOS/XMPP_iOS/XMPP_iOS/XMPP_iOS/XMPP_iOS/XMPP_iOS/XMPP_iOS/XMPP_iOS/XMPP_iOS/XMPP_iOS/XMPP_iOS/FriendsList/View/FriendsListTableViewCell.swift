//
//  FriendsListTableViewCell.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/12.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit
import XMPPFramework

let FriendsListTableViewCellIdent = "FriendsListTableViewCellIdent"

class FriendsListTableViewCell: UITableViewCell {

    class func dequeueReusableCell(withTableView tableView: UITableView)  -> FriendsListTableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsListTableViewCellIdent) as? FriendsListTableViewCell
        
        return cell
    }
    
    public func fillCell(withUserCoreDataStorageObject object: XMPPUserCoreDataStorageObject?) {
        guard let object = object else { return }
        self.imageView?.image = object.photo ?? UIImage.init(named: "userIcon")
        textLabel?.text = object.nickname
        
        if let chatRecordsArray = XMPPManager.manager.getChatRecords(withFriendName: object.displayName) as? Array<XMPPMessageArchiving_Message_CoreDataObject> {
            detailTextLabel?.text = chatRecordsArray.last?.body
        }
    }
    
    override init(style: UITableViewCellStyle,
                  reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.imageView?.layer.backgroundColor = UIColor.red.cgColor
        self.imageView?.layer.cornerRadius = 5
        self.imageView?.clipsToBounds = true
        self.textLabel?.textColor = UIColor.darkGray
        self.detailTextLabel?.textColor = UIColor.lightGray
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.x(10).y(8).height(self.height - 16).width(self.height - 16)
        self.textLabel?.x((self.imageView?.rightX)! + 10).y((self.imageView?.y)! + 5)
        self.detailTextLabel?.x((self.textLabel?.x)!).y((self.textLabel?.bottomY)! + 5)
    }
}
