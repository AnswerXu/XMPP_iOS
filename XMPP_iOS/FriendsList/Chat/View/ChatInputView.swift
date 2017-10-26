//
//  ChatInputView.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/17.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

class ChatInputView: UIView {
    
    // 语音
    lazy var voiceItem : UIButton = {
        let item = UIButton.init(type: .custom)
        item.setImage(#imageLiteral(resourceName: "ToolViewInputVoice"), for: .normal)
        item.setImage(#imageLiteral(resourceName: "ToolViewInputText"), for: .selected)
        item.addTarget(self, action: #selector(voiceItemAction(sender:)),
                       for: .touchUpInside)
        return item
    }()
    // 表情
    lazy var emojiItem : UIButton = {
        let item = UIButton.init(type: .custom)
        item.setImage(#imageLiteral(resourceName: "ToolViewEmotion"), for: .normal)
        item.setImage(#imageLiteral(resourceName: "ToolViewInputText"), for: .selected)
        item.addTarget(self, action: #selector(emojiItemAction(sender:)),
                       for: .touchUpInside)
        return item
    }()
    // 加号
    lazy var plusItem : UIButton = {
        let item = UIButton.init(type: .custom)
        item.setImage(#imageLiteral(resourceName: "TypeSelectorBtn_Black"), for: .normal)
        item.setImage(#imageLiteral(resourceName: "TypeSelectorBtnHL_Black"), for: .highlighted)
        item.addTarget(self, action: #selector(plusItemAciton(sender:)),
                       for: .touchUpInside)
        return item
    }()
    // 输入框
    lazy var inputTextView : UITextView = {
        let textView = UITextView.init()
        textView.textColor = UIColor.darkText
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.layer.cornerRadius = 5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 0.5
        return textView
    }()
    
    // 按住说话
    lazy var pressSpeakItem : UIButton = {
        let item = UIButton.init(type: .custom)
        item.setTitle("按住 说话", for: .normal)
        item.setTitleColor(UIColor.darkGray, for: .normal)
        item.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        item.layer.cornerRadius = 5
        item.layer.borderColor = UIColor.lightGray.cgColor
        item.layer.borderWidth = 0.5
        item.addTarget(self, action: #selector(pressSpeakItemTouchDownAction(sender:)), for: .touchDown)
        item.addTarget(self, action: #selector(pressSpeakItemTouchDragExitAction(sender:)), for: .touchDragExit)
        item.addTarget(self, action: #selector(pressSpeakItemTouchUpOutsideAciton(sender:)), for: .touchUpOutside)
        item.addTarget(self, action: #selector(pressSpeakItemTouchDragEnterAction(sender:)), for: .touchDragEnter)
        item.addTarget(self, action: #selector(pressSpeakItemTouchUpInsideAction(sender:)), for: .touchUpInside)
        item.isHidden = true
        return item
    }()

    class func inputView() -> ChatInputView {
        let rect = CGRect.init(x: 0, y: ScreenH - NavigationBar_Height - ToolBar_Height, width: ScreenW, height: ToolBar_Height)
        let inputView = ChatInputView.init(frame: rect)
        inputView.setupInputView()
        return inputView
    }
    
    private func setupInputView() {
        self.backgroundColor = UIColor.hexColorWith(hexVale: 0xf5f5f5)
        self.addSubview(voiceItem)
        self.addSubview(emojiItem)
        self.addSubview(plusItem)
        self.addSubview(inputTextView)
        self.addSubview(pressSpeakItem)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.voiceItem.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(35)
        }
        self.plusItem.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalTo(self.voiceItem)
            make.width.height.equalTo(self.voiceItem)
        }
        self.emojiItem.snp.makeConstraints { (make) in
            make.right.equalTo(self.plusItem.snp.left).offset(-5)
            make.centerY.equalTo(self.voiceItem)
            make.width.height.equalTo(self.voiceItem)
        }
        self.inputTextView.snp.makeConstraints { (make) in
            make.left.equalTo(self.voiceItem.snp.right).offset(5)
            make.right.equalTo(self.emojiItem.snp.left).offset(-5)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
        }
        self.pressSpeakItem.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self.inputTextView)
        }
    }
}

// MARK:-  事件监听
extension ChatInputView {
    // 语音按钮事件监听
    @objc func voiceItemAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            // 语音输入
            self.pressSpeakItem.isHidden = false
            self.inputTextView.resignFirstResponder()
            self.inputTextView.isHidden = true
        }else{
            // 键盘输入
            self.pressSpeakItem.isHidden = true
            self.inputTextView.isHidden = false
            self.inputTextView.inputView = nil
            self.inputTextView.becomeFirstResponder()
        }
    }
    
    // 表情按钮事件监听
    @objc func emojiItemAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            // 弹出表情键盘
            self.inputTextView.resignFirstResponder()
            // 设置表情键盘
            self.inputTextView.inputView = {
                let emojiView = UIView.init(frame: CGRect.init(origin: .zero, size: CGSize.init(width: ScreenW, height: 200)))
                emojiView.backgroundColor = UIColor.cyan
                return emojiView
            }()
            // 重新设置为第一响应者
            self.inputTextView.becomeFirstResponder()
        }else{
            // 弹出系统键盘
            self.inputTextView.resignFirstResponder()
            self.inputTextView.inputView = nil
            self.inputTextView.becomeFirstResponder()
        }
    }
    
    // 加号按钮事件监听
    @objc func plusItemAciton(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            // 弹出自定义键盘
            self.inputTextView.resignFirstResponder()
            self.inputTextView.inputView = {
                let customView = UIView.init(frame: CGRect.init(origin: .zero, size: CGSize.init(width: ScreenW, height: 200)))
                customView.backgroundColor = UIColor.red
                return customView
            }()
            // 重新设置为第一响应者
            self.inputTextView.becomeFirstResponder()
        }else{
            // 弹出系统键盘
            self.inputTextView.resignFirstResponder()
            self.inputTextView.inputView = nil
            self.inputTextView.becomeFirstResponder()
        }
    }
    
    // pressSpeakItem按钮事件监听
    @objc func pressSpeakItemTouchDownAction(sender: UIButton) {
        sender.setTitle("松开 结束", for: .normal)
        print(#function)
    }
    @objc func pressSpeakItemTouchDragExitAction(sender: UIButton) {
        sender.setTitle("松开 取消", for: .normal)
        print(#function)
    }
    @objc func pressSpeakItemTouchDragEnterAction(sender: UIButton) {
        sender.setTitle("松开 结束", for: .normal)
        print(#function)
    }
    @objc func pressSpeakItemTouchUpOutsideAciton(sender: UIButton) {
        sender.setTitle("按住 说话", for: .normal)
        print(#function)
    }
    @objc func pressSpeakItemTouchUpInsideAction(sender: UIButton) {
        sender.setTitle("按住 说话", for: .normal)
        print(#function)
    }
}
