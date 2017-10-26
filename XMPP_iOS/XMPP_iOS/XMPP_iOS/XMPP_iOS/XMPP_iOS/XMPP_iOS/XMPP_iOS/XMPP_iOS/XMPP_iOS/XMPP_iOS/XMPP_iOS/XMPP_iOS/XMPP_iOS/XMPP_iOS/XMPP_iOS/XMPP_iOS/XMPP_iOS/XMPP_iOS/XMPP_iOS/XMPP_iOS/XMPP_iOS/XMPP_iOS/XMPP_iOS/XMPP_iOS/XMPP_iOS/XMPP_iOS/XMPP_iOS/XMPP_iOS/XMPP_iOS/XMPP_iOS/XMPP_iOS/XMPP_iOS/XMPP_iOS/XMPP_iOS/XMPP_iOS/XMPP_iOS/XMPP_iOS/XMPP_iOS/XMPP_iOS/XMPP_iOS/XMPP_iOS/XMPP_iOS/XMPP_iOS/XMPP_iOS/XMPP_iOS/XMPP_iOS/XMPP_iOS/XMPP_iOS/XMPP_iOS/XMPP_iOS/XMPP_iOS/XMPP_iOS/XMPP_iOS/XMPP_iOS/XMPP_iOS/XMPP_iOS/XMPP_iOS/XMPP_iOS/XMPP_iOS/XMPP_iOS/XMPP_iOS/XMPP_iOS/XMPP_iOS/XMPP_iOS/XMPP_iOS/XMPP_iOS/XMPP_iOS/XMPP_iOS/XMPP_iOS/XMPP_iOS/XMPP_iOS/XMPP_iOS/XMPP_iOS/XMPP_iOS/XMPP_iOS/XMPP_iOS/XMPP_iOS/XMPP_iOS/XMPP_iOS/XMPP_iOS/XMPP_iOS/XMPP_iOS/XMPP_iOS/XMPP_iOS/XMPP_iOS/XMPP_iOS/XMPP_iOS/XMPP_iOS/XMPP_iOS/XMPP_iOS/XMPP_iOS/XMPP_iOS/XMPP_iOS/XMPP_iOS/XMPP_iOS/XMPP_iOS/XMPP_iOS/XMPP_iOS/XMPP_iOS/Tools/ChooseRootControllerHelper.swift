//
//  ChooseRootControllerHelper.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/16.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

class ChooseRootControllerHelper: NSObject {
    
    // 登录控制器
    private let loginViewController : LoginViewController = {
        return LoginViewController.init()
    }()
    
    // 主控制器
    private let tabbarViewController : XMPPTabBarController = {
        return XMPPTabBarController.init()
    }()

    // 单列
    static let helper : ChooseRootControllerHelper = {
        return ChooseRootControllerHelper.init()
    }()
    
    func chooseRootController() {
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.rootViewController = getLoginMark() ? tabbarViewController : loginViewController
        keyWindow?.makeKeyAndVisible()
    }
    
    func saveLoginMark(withState state: Bool) {
        UserDefaults.standard.set(state, forKey: key_loginMark)
        UserDefaults.standard.synchronize()
    }
    
    func getLoginMark() -> Bool {
        if let result = UserDefaults.standard.object(forKey: key_loginMark) as? Bool {
            return result
        }
        return false
    }
}
