//
//  ChatTableView.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/16.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit
import XMPPFramework

class ChatTableView: UITableView {
    
    lazy var dataArray : Array<Any> = {
        return Array.init()
    }()

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        self.register(ChatLeftTableViewCell.self, forCellReuseIdentifier: chatLeftCellIdent)
        self.register(ChatRightTableViewCell.self, forCellReuseIdentifier: chatRightCellIdent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}

extension ChatTableView : UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChatLeftTableViewCell.dequeueReusableLeftCell(withTableView: tableView)
        if let coreDataObject = self.dataArray[indexPath.row] as? XMPPMessageArchiving_Message_CoreDataObject {
            cell?.fillCell(withIconImage: #imageLiteral(resourceName: "userIcon"), message: coreDataObject.body)
        }
        return cell!
    }
}

extension ChatTableView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
