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
    }
    
    override init(style: UITableViewCellStyle,
                  reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.imageView?.layer.backgroundColor = UIColor.red.cgColor
        self.textLabel?.textColor = UIColor.black
        self.textLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout() {
        self.imageView?.x(10).height(30).width(30).centerY(self.height * 0.5)
        self.textLabel?.x((self.imageView?.rightX)! + 10).centerY(self.height * 0.5)
    }
}
