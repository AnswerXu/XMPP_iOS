//
//  MeSection0TableViewCell.swift
//  XMPP_iOS
//
//  Created by 澳蜗科技 on 2017/10/20.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

let meSection0CellIdent = "meSection0CellIdent"
class MeSection0TableViewCell: UITableViewCell {
    
    private lazy var codeImageView : UIImageView = {
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "setting_myQR"))
        imageView.sizeToFit()
        return imageView
    }()

    override init(style: UITableViewCellStyle,
                  reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        imageView?.layer.cornerRadius = 5
        imageView?.clipsToBounds = true
        textLabel?.font = UIFont.systemFont(ofSize: 15)
        textLabel?.textColor = UIColor.black
        detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        detailTextLabel?.textColor = UIColor.black
        self.contentView.addSubview(codeImageView)
        self.accessoryType = .disclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.size(60, height: 60).centerY(self.height * 0.5)
        self.textLabel?.x((self.imageView?.rightX)! + 10).y((self.imageView?.y)! + 10)
        self.detailTextLabel?.x((self.textLabel?.x)!).bottomY((self.imageView?.bottomY)! - 10)
        self.codeImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-5)
            make.centerY.equalTo(self.height * 0.5)
        }
    }
}
