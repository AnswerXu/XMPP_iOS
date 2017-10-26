//
//  MeModel.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/20.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

class MeModel: NSObject {
    
    var image : UIImage?
    
    var imageName : String? {
        didSet{
            guard let name = imageName else { return }
            image = UIImage.init(named: name)
        }
    }
    
    var text : String?
    
    convenience init(dict: [String : String]?) {
        self.init()
        guard let dict = dict else { return }
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
