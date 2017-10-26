//
//  LoginViewController.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/11.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit
import XMPPFramework

class LoginViewController: UIViewController {

    // MARK:- 拖线属性
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加代理
        XMPPManager.manager.xmppStream?.addDelegate(self, delegateQueue: DispatchQueue.main)
    }
    
    
    // MARK:- 登录按钮方法
    @IBAction func loginButtonAction(_ sender: UIButton) {
        // 发送登录请求
        XMPPManager.manager.login(widthUserName: userNameTextField.text, andPassword: passwordTextField.text)
    }
    // MARK:- 注册按钮方法
    @IBAction func registerButtonAction(_ sender: UIButton) {
        // 跳转到注册控制器
        let registerVC = RegisterViewController.init()
        // 接收注册控制的闭包
        registerVC.sendPasswordHandle = { [weak self] (userName : String?) in
            self?.userNameTextField.text = userName
        }
        self.present(registerVC, animated: true, completion: nil)
    }
    
}

// MARK:- XMPPStreamDelegate
extension LoginViewController : XMPPStreamDelegate {
    // 登录成功
    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
        print("登录成功  ", #line, #function)
        
        // 保存用户名到本地
        UserDefaults.standard.set(userNameTextField.text, forKey: key_userName)
        UserDefaults.standard.set(passwordTextField.text, forKey: key_password)
        UserDefaults.standard.synchronize()
        
        // 切换窗口根控制器
        let helper = ChooseRootControllerHelper.helper
        helper.saveLoginMark(withState: true)
        helper.chooseRootController()
    }
    
    // 登录失败
    func xmppStream(_ sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        print("登录失败")
    }
}
