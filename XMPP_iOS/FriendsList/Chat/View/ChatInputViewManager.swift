//
//  ChatInputViewManager.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/17.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

// 发送消息的代理
protocol ChatInputViewManagerDelegate : NSObjectProtocol {
    func chatInputViewSendMessage(text: String)
}

class ChatInputViewManager: NSObject {
    
    var inputView : ChatInputView? {
        didSet{
            guard let inputView = inputView else { return }
            inputView.inputTextView.delegate = self
        }
    }
    
    var tableView : ChatTableView? {
        didSet{
            guard let tableView = tableView else { return }
            tableView.inputViewEndEditingClosure = {[weak self] in
                self?.inputView?.endEditing(true)
            }
        }
    }
    
    weak var delegate : ChatInputViewManagerDelegate?
    
    // 销毁观察者
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // 类方法
    class func manager() -> ChatInputViewManager {
        let manager = ChatInputViewManager.init()
        manager.addObserverAboutKeyboard()
        return manager
    }
    
    // 监听键盘
    private func addObserverAboutKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWithChange(info:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWithChange(info:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWithChange(info: NSNotification) {
        guard let userInfo = info.userInfo else { return }
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
        guard let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        keyboardChangeAnimation(duration: duration ?? 0, isShow: endFrame.minY < ScreenH, distanceY: endFrame.height)
    }
    
    private func keyboardChangeAnimation(duration: TimeInterval,
                                         isShow: Bool,
                                         distanceY: CGFloat) {
        guard let inputView = self.inputView else { return }
        guard let tableView = self.tableView else { return }
        UIView.animate(withDuration: duration) {
            if isShow {
                inputView.transform = CGAffineTransform.init(translationX: 0, y: -distanceY)
                tableView.transform = CGAffineTransform.init(translationX: 0, y: -distanceY)
            }else{
                inputView.transform = CGAffineTransform.identity
                tableView.transform = CGAffineTransform.identity
            }
        }
    }
}

// MARK:- UITextViewDelegate
extension ChatInputViewManager : UITextViewDelegate {
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if text == "\n" {
            if let delegate = self.delegate {
                delegate.chatInputViewSendMessage(text: textView.text)
            }
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
}
