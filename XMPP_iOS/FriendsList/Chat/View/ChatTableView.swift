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
    
    var dataArray : Array<Any>? {
        didSet{
            guard let array = dataArray else { return }
            chatModels = Array<ChatModel>.init()
            for object in array {
                let chatModel = ChatModel.init(withCoreDataObject: object as? XMPPMessageArchiving_Message_CoreDataObject)
                chatModels?.append(chatModel)
            }
        }
    }
    
    var chatModels : Array<ChatModel>?
    
    // 输入框放弃第一响应者的闭包
    var inputViewEndEditingClosure : (()->Void)?
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        self.separatorStyle = .none
        self.register(ChatLeftTableViewCell.self,
                      forCellReuseIdentifier: chatLeftCellIdent)
        self.register(ChatRightTableViewCell.self,
                      forCellReuseIdentifier: chatRightCellIdent)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // 输入框结束编辑
        if let closure = inputViewEndEditingClosure { closure() }
        return super.hitTest(point, with: event)
    }
}

// MARK:- UITableViewDelegate
extension ChatTableView : UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return chatModels?[indexPath.row].rowHeight ?? 0
    }
}

// MARK:- UITableViewDataSource
extension ChatTableView : UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.chatModels?.count ?? 0
    }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatModel = self.chatModels?[indexPath.row]
        if chatModel?.coreDataObject?.outgoing != 0 {
            // 表示发送
            let cell = ChatRightTableViewCell.dequeueReusableRightCell(withTableView: tableView)
            cell?.fillCell(withModel: chatModel)
            return cell!
        }else{
            // 表示接收
            let cell = ChatLeftTableViewCell.dequeueReusableLeftCell(withTableView: tableView)
            cell?.indexPath = indexPath
            cell?.fillCell(withModel: chatModel)
            return cell!
        }
    }
}
