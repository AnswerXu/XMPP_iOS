//
//  XMPPManager.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/11.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit
import XMPPFramework

// 枚举：连接服务器的目的
enum ConnectServerPurpose : Int{
    case connectServerToLogin     // 登录
    case connectServerToRegister  // 注册
}

class XMPPManager: NSObject {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate var password : String?
    fileprivate var userName : String?
    fileprivate var connectServerPurpose : ConnectServerPurpose = .connectServerToLogin
    
    // 通信通道对象
    var xmppStream : XMPPStream?
    // JID
    var xmppJID : XMPPJID?
    // 好友花名册管理对象
    var xmppRoster : XMPPRoster?
    // 花名册数据存储对象
    var xmppRosterCoreDataStorage : XMPPRosterCoreDataStorage?
    // 信息归档对象
    var xmppMessageArchiving : XMPPMessageArchiving?
    // 信息存储对象
    var xmppMessageArchivingCoreDataStorage : XMPPMessageArchivingCoreDataStorage?
    
    var friendsListResultController : NSFetchedResultsController<NSFetchRequestResult>?
    var chatRecordsResultController : NSFetchedResultsController<NSFetchRequestResult>?
    // 好友请求
    var xmppPresence : XMPPPresence?
    
    // 单例
    static let manager : XMPPManager = {
        let manager = XMPPManager.init()
        // 创建通信通道对象
        manager.xmppStream = XMPPStream.init()
        // 设置服务器IP地址
        manager.xmppStream?.hostName = kHostName
        // 设置服务器端口
        manager.xmppStream?.hostPort = kHostPort
        // 添加代理
        manager.xmppStream?.addDelegate(manager, delegateQueue: DispatchQueue.main)
        
        // 花名册数据存储对象
        manager.xmppRosterCoreDataStorage = XMPPRosterCoreDataStorage.sharedInstance()
        manager.xmppRoster = XMPPRoster.init(rosterStorage: manager.xmppRosterCoreDataStorage)
//        manager.xmppRoster?.autoFetchRoster = true
//        manager.xmppRoster?.autoAcceptKnownPresenceSubscriptionRequests = true
        manager.xmppRoster?.activate(manager.xmppStream)
        manager.xmppRoster?.addDelegate(manager, delegateQueue: DispatchQueue.main)
        
        // 信息存储对象
        manager.xmppMessageArchivingCoreDataStorage = XMPPMessageArchivingCoreDataStorage.sharedInstance()
        manager.xmppMessageArchiving = XMPPMessageArchiving.init(messageArchivingStorage: manager.xmppMessageArchivingCoreDataStorage, dispatchQueue: DispatchQueue.main)
        // 激活通信通道对象
        manager.xmppMessageArchiving?.activate(manager.xmppStream)

        return manager
    }()
    
    // 连接服务器
    func connectToServer(withUserName userName: String) {
        // 创建XMPPJID对象
        self.xmppJID = XMPPJID.init(user: userName, domain: kDomin, resource: kResource)
        // 设置通信通道对象的JID
        self.xmppStream?.myJID = self.xmppJID
        // 发送请求
        if self.xmppStream?.isConnected() == true || self.xmppStream?.isConnecting() == true {
            // 先退出登录状态
           self.exitLogin()
        }
        // 连接服务器
        do {
            try self.xmppStream?.connect(withTimeout: -1)
        }catch let error as NSError{
            print("连接服务器失败: " + error.description)
        }
    }
}

// MARK:- 登录方法
extension XMPPManager {
    // 登录方法
    func login(widthUserName userName: String?, andPassword password: String?) {
        guard let userName = userName, let password = password else {
            print("用户名和密码不能为空")
            return
        }
        // 记录连接服务器的目的是登录
        connectServerPurpose = .connectServerToLogin
        // 记录登录信息
        self.password = password
        self.userName = userName
        connectToServer(withUserName: userName)
    }
    
    // 退出登录
    func exitLogin() {
        // 先发送下线状态
        let presence = XMPPPresence.init(type: "unavailable")
        self.xmppStream?.send(presence)
        // 断开连接
        self.xmppStream?.disconnect()
    }
}

// MARK:- 注册方法
extension XMPPManager {
    func register(widthUserName userName: String?, andPassword password: String?) {
        guard let userName = userName, let password = password else {
            print("用户名和密码不能为空")
            return
        }
        // 记录连接服务器的目的是注册
        connectServerPurpose = .connectServerToRegister
        // 记录密码
        self.password = password
        connectToServer(withUserName: userName)
    }
}

// MARK:- XMPPStreamDelegate
extension XMPPManager : XMPPStreamDelegate {
    // 连接成功
    func xmppStreamDidConnect(_ sender: XMPPStream!) {
        print("连接成功")
        switch connectServerPurpose {
            case .connectServerToLogin:
                // 验证密码
                do {
                    try self.xmppStream?.authenticate(withPassword: self.password)
                } catch let error as NSError {
                    print("登录时验证密码失败： " + error.description)
                }
                break
            case .connectServerToRegister:
                do {
                    try self.xmppStream?.register(withPassword: self.password)
                } catch let error as NSError {
                    print("注册时验证密码失败： " + error.description)
                }
                break
        }
    }
    
    // 连接超时
    func xmppStreamConnectDidTimeout(_ sender: XMPPStream!) {
        print("连接超时")
    }
    
    // 登录成功
    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
        print("登录成功  ", #line, #function)
        // 发送上线状态
        let presence = XMPPPresence.init(type: "available")
        XMPPManager.manager.xmppStream?.send(presence)
    }
    // 登录失败
    func xmppStream(_ sender: XMPPStream!,
                    didNotAuthenticate error: DDXMLElement!) {
        
        if ChooseRootControllerHelper.helper.getLoginMark() == true {
            // 如果仍保持上次的登录状态，则退出上次的登录状态并切换到登录控制器
            ChooseRootControllerHelper.helper.saveLoginMark(withState: false)
            ChooseRootControllerHelper.helper.chooseRootController()
        }else{
            print("登录失败")
        }
    }
    
    // 已经断开连接
    func xmppStreamDidDisconnect(_ sender: XMPPStream!,
                                 withError error: Error!) {
        print("已经断开连接")
    }
    
//    func xmppStream(_ sender: XMPPStream!,
//                    didReceive presence: XMPPPresence!) {
//        // 收到对方取消定阅我的消息
//        if presence.type() == "unsubscribe" {
//            // 从我的本地通讯录中将他移除
//            self.xmppRoster?.removeUser(presence.from())
//        }
//    }
}

// MARK:- 好友
extension XMPPManager {
    // 添加好友
    func addNewFriends(userName: String?) {
        guard let name = userName else { return }
        let friendJID = XMPPJID.init(string: "\(name)@\(kDomin)")
        self.xmppRoster?.subscribePresence(toUser: friendJID)
    }
    
    // 获取好友列表
    func getFriendsList() -> Array<Any>? {
        guard let context = self.xmppRosterCoreDataStorage?.mainThreadManagedObjectContext else {
            return nil
        }
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "XMPPUserCoreDataStorageObject")
        let userInfo = String.init(format: "%@@%@", self.userName ?? "", kDomin)
        // 谓词
        let predicate = NSPredicate.init(format: "streamBareJidStr = %@", userInfo)
        request.predicate = predicate
        
        // 排序
        let sort = NSSortDescriptor.init(key: "displayName", ascending: true)
        request.sortDescriptors = [sort]
        
        friendsListResultController = NSFetchedResultsController.init(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        friendsListResultController?.delegate = self
        do {
            try friendsListResultController?.performFetch()
        } catch let error as NSError {
            print("获取好友聊天记录失败： " + error.description)
        }
        return friendsListResultController?.fetchedObjects
    }
    
    // 获取与某个好友的聊天记录
    func getChatRecords(withFriendName friendName: String) ->Array<Any>?{
        guard let context = self.xmppMessageArchivingCoreDataStorage?.mainThreadManagedObjectContext else { return nil}
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "XMPPMessageArchiving_Message_CoreDataObject")
        let userInfo = String.init(format: "%@@%@", self.userName ?? "", kDomin)
        let friendsInfo = String.init(format: "%@@%@", friendName, kDomin)
        // 谓词
        let predicate = NSPredicate.init(format: "streamBareJidStr=%@ AND bareJidStr=%@", userInfo, friendsInfo)
        request.predicate = predicate
        
        // 排序
        let sort = NSSortDescriptor.init(key: "timestamp", ascending: true)
        request.sortDescriptors = [sort]
        
        chatRecordsResultController = NSFetchedResultsController.init(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        chatRecordsResultController?.delegate = self
        do {
            try chatRecordsResultController?.performFetch()
        } catch let error as NSError {
            print("获取好友聊天记录失败： " + error.description)
        }
        guard let fetchedObjects = chatRecordsResultController?.fetchedObjects else { return nil }
        var messageArray = Array<Any>()
        for obj in fetchedObjects {
            if let _ = (obj as? XMPPMessageArchiving_Message_CoreDataObject)?.body {
                messageArray.append(obj)
            }
        }
        return messageArray
    }
}

// MARK:- XMPPRosterDelegate
extension XMPPManager : XMPPRosterDelegate {
    func xmppRoster(_ sender: XMPPRoster!,
                    didReceiveRosterItem item: DDXMLElement!) {
        print(#line, #function, item)
    }
    func xmppRosterDidBeginPopulating(_ sender: XMPPRoster!,
                                      withVersion version: String!) {
        print(#line, #function)
    }
    func xmppRosterDidEndPopulating(_ sender: XMPPRoster!) {
        print(#line, #function)
    }
    
    // 收到出席订阅请求（代表对方想添加自己为好友)
    func xmppRoster(_ sender: XMPPRoster!,
                    didReceivePresenceSubscriptionRequest presence: XMPPPresence!) {
        self.xmppPresence = presence
        
        
//        // 好友在线状态
//        guard let type = presence.type() else { return }
//        let fromUser = presence.from().user
//        let user = self.xmppStream?.myJID.user
//        print("接收到状态为：\(type),来自发送者\(fromUser),接收者\(user)")
//        
//        // 防止自己添加自己为好友
//        if fromUser != user{
//            switch type {
//            case "available":
//                print("好友上线")
//            case "away":
//                print("好友离开")
//            case "do not disturb":
//                print("好友忙碌")
//            case "unavailable":
//                print("好友下线")
//            case "subscribe":
//                print("请求添加好友")
//                let alert = UIAlertView.init(title: "好友请求", message: "\(fromUser) 请求添加你为好友", delegate: self, cancelButtonTitle: "拒绝", otherButtonTitles: "同意")
//                alert.show()
//            case "unsubscribe":
//                print("请求并删除了我这个好友")
//            case "unsubscribed":
//                print("对方拒绝了我的好友请求")
//            case "error":
//                print("错误信息")
//            default:
//                print("其它信息 type = \(type)")
//            }
//        }
        
        
//        print(presence.type())
//        // 收到对方取消定阅我的消息
//        if presence.type() == "unsubscribe" {
//            // 从我的本地通讯录中将他移除
//            self.xmppRoster?.removeUser(presence.from())
//        }

//        if presence.type() == "subscribe" {
//            // 收到对方订阅我的消息
//            let alert = UIAlertView.init(title: "好友请求", message: "\(presence.from().user ?? "**") 请求添加你为好友", delegate: self, cancelButtonTitle:
//                "拒绝", otherButtonTitles: "同意")
//            alert.show()
//        }
    }
}

// MARK:- 好友请求弹框
extension XMPPManager : UIAlertViewDelegate {
    func alertView(_ alertView: UIAlertView,
                   clickedButtonAt buttonIndex: Int) {
        guard let presence = self.xmppPresence else { return }
        switch buttonIndex {
        case 0:
            // 拒绝
            let jid = XMPPJID.init(string: presence.from().user)
            self.xmppRoster?.rejectPresenceSubscriptionRequest(from: jid)
            break
        case 1:
            // 同意
            let jid = XMPPJID.init(string: presence.from().user)
            self.xmppRoster?.acceptPresenceSubscriptionRequest(from: jid, andAddToRoster: true)
            break
        default: break
        }
    }
}

// MARK:- NSFetchedResultsControllerDelegate
extension XMPPManager : NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        if anObject is XMPPUserCoreDataStorageObject {
            // 好友列表数据库发生变化
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName_friendsListDidChange), object: nil)
        }else if anObject is XMPPMessageArchiving_Message_CoreDataObject{
            // 聊天记录数据库发生变化
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName_chatRecordsDidChange), object: nil)
        }
    }
}
