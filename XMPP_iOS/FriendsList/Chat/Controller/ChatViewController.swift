//
//  ChatViewController.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/16.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit
import XMPPFramework

class ChatViewController: UIViewController {

    var userCoreDataStorageObject : XMPPUserCoreDataStorageObject?
    
    fileprivate lazy var tableView : ChatTableView = {
        let rect = CGRect.init(origin: self.view.origin, size: CGSize.init(width: ScreenW, height: ScreenH - ToolBar_Height))
        let tableView = ChatTableView.init(frame: rect, style: .plain)
        self.inputViewManager.tableView = tableView
        return tableView
    }()
    
    fileprivate lazy var chatInputView : ChatInputView = {
        let chatInputView = ChatInputView.inputView()
        self.inputViewManager.inputView = chatInputView
        return chatInputView
    }()
    
    fileprivate lazy var inputViewManager : ChatInputViewManager = {
        let manager = ChatInputViewManager.manager()
        manager.delegate = self
        return manager
    }()
    
    deinit {
        // 销毁观察者
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = userCoreDataStorageObject?.displayName
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.chatInputView)
        
        // 监听好友列表变化
        NotificationCenter.default.addObserver(self, selector: #selector(reloadChatRecords), name: NSNotification.Name(rawValue: notificationName_chatRecordsDidChange), object: nil)
        
        reloadChatRecords()
        
        // 通信通道对象添加代理
        XMPPManager.manager.xmppStream?.addDelegate(self, delegateQueue: DispatchQueue.main)
    }
    
    // 好友列表发生变化的监听方法
    @objc private func reloadChatRecords() {
        // 获取好友列表信息数组
        guard let object = userCoreDataStorageObject else { return }
        guard let chatRecordsArray = XMPPManager.manager.getChatRecords(withFriendName: object.displayName) else { return }
        // 刷新好友列表
        tableView.dataArray = chatRecordsArray
        tableView.reloadData()
        DispatchQueue.main.async {
            if self.tableView.numberOfRows(inSection: 0) >= 1 {
                self.tableView.scrollToRow(at: IndexPath.init(row: self.tableView.numberOfRows(inSection: 0) - 1, section: 0), at: .bottom, animated: true)
            }
        }
    }
}

// MARK:- ChatInputViewManagerDelegate
extension ChatViewController : ChatInputViewManagerDelegate, XMPPStreamDelegate {
    // ChatInputViewManagerDelegate
    func chatInputViewSendMessage(text: String) {
        if let jid = userCoreDataStorageObject?.jid {
            // 发送文字消息
            sendMessage(withText: text, userJID: jid)
            self.chatInputView.inputTextView.text = ""
        }
    }
    // 发送文字消息的方法
    private func sendMessage(withText text: String,
                            userJID: XMPPJID){
        let message = XMPPMessage.init(type: "chat", to: userJID)
        message?.addBody(text)
        // 发送消息
        XMPPManager.manager.xmppStream?.send(message)
    }
    
    // XMPPStreamDelegate：发送消息成功的方法
    func xmppStream(_ sender: XMPPStream!,
                    didSend message: XMPPMessage!) {
    }
    
    // XMPPStreamDelegate：发送消息失败的方法
    func xmppStream(_ sender: XMPPStream!,
                    didFailToSend message: XMPPMessage!,
                    error: Error!) {
        
    }

}
