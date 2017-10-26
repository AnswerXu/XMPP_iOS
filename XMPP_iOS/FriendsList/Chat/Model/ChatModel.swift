//
//  ChatModel.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/18.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit
import XMPPFramework

class ChatModel: NSObject {
    
    var coreDataObject : XMPPMessageArchiving_Message_CoreDataObject? {
        didSet{
            guard let object = coreDataObject else { return }
            guard let message = object.body as NSString? else { return }
            let rect = message.boundingRect(with: CGSize.init(width: ScreenW - 55*2, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading, .usesDeviceMetrics, .truncatesLastVisibleLine], attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15)], context: nil)
            
            rowHeight = rect.size.height + 40
            messageSize = rect.size
        }
    }
    
    var iconImage : UIImage? = #imageLiteral(resourceName: "userIcon")
    
    var rowHeight : CGFloat = 0.0
    
    var messageSize : CGSize = .zero
    
    convenience init(withCoreDataObject object: XMPPMessageArchiving_Message_CoreDataObject?) {
        self.init()
        guard let object = object else { return }
        setValue(object, forKey: "coreDataObject")
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
