//
//  XMPPTabBarController.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/16.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

class XMPPTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 聊天列表
        let chatListVC = ChatListViewController.init()
        self.setupChildViewController(child: chatListVC, title: "微信", imageName: "tabbar_mainframe")
        
        // 通讯录
        let friendsListVC = FriendsListViewController.init()
        self.setupChildViewController(child: friendsListVC, title: "通讯录", imageName: "tabbar_contacts")
        
        // 发现
        let discoverVC = DiscoverViewController.init()
        self.setupChildViewController(child: discoverVC, title: "发现", imageName: "tabbar_discover")
        
        // 我
        let meVC = MeViewController.init()
        self.setupChildViewController(child: meVC, title: "我", imageName: "tabbar_me")
        
        //  设置tabbar的titColor
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 10), NSForegroundColorAttributeName : UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 10), NSForegroundColorAttributeName : UIColor.hexColorWith(hexVale: 0x09bb07)], for: .selected)

    }
    
    private func setupChildViewController(child: UIViewController, title: String, imageName: String) {
        let chatListNavi = XMPPNavigationController.init(rootViewController: child)
        child.title = title
        chatListNavi.tabBarItem.title = title
        chatListNavi.tabBarItem.image = UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        chatListNavi.tabBarItem.selectedImage = UIImage.init(named: imageName + "HL")?.withRenderingMode(.alwaysOriginal)
        self.addChildViewController(chatListNavi)
    }
}
