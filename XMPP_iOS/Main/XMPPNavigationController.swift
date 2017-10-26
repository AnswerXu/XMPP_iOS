//
//  XMPPNavigationController.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/16.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

class XMPPNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(#imageLiteral(resourceName: "topbarbg_ios7"), for: .default)
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName : UIFont.systemFont(ofSize: 15)], for: .normal)
        navigationController?.navigationBar.isTranslucent = true
    }
}
