//
//  RegisterViewController.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/11.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit
import XMPPFramework

class RegisterViewController: UIViewController {

    // MARK:- 拖线属性
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // 回调用户名到登录控制器的闭包
    var sendPasswordHandle : ((String?)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加代理
        XMPPManager.manager.xmppStream?.addDelegate(self, delegateQueue: DispatchQueue.main)

    }
    
    // MARK:- 返回按钮方法
    @IBAction func backButtonAciton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK:- 注册按钮方法
    @IBAction func registerButtonAciton(_ sender: UIButton) {
        XMPPManager.manager.register(widthUserName: userNameTextField.text, andPassword: passwordTextField.text)
    }
    
}

// MARK:- XMPPStreamDelegate
extension RegisterViewController : XMPPStreamDelegate {
    // 注册成功
    func xmppStreamDidRegister(_ sender: XMPPStream!) {
        // 回调用户名到登录控制器
        if let handle = sendPasswordHandle {
            handle(self.userNameTextField.text)
        }
        // 返回登录控制器
        self.dismiss(animated: true, completion: nil)
    }
    
    // 注册失败
    func xmppStream(_ sender: XMPPStream!, didNotRegister error: DDXMLElement!) {
        print("新用户注册失败")
    }
}
