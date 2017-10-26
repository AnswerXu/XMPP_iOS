//
//  UIColor+Extension.swift
//
//  Created by 澳蜗科技 on 2017/4/14.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//

import UIKit

extension UIColor {
    
    // hexVale: 0xFFFFFF
    // alpha: 0~1
    public class func hexColorWith(hexVale: UInt32, alpha: CGFloat) ->UIColor {
        let r  =  (hexVale & 0xFF0000) >> 16
        let g = (hexVale & 0x00FF00) >> 8
        let b = hexVale & 0x0000FF
        return UIColor.init(red: CGFloat(r) / CGFloat(255), green: CGFloat(g) / CGFloat(255), blue: CGFloat(b) / CGFloat(255), alpha: alpha)
    }
    
    public class func hexColorWith(hexVale: UInt32) ->UIColor {
        return hexColorWith(hexVale: hexVale, alpha: 1)
    }
    
    // hexVale: "#FFFFFF"  || "FFFFFF"
    // alpha: 0~1
    public class func hexColorWith(hexString: String, alpha: CGFloat) -> UIColor {
        // 删除字符串中的空格
        var hexStr = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        // String should be 6 or 8 characters
        if hexStr.characters.count < 6{
            return UIColor.clear
        }
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
        if hexStr.hasPrefix("0x") || hexStr.hasPrefix("0X") {
            hexStr = hexStr.substring(from: hexStr.index(hexStr.startIndex, offsetBy: hexStr.characters.count - 2))
        }
        //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
        if hexStr.hasPrefix("#") {
            hexStr = hexStr.substring(from: hexStr.index(hexStr.startIndex, offsetBy: hexStr.characters.count - 1))
        }
        if hexStr.characters.count != 6 {
            return UIColor.clear
        }
        // String -> UInt32
        var hexValue : UInt32 = 0x000000
        Scanner.init(string: hexStr).scanHexInt32(&hexValue)
        
        return hexColorWith(hexVale: hexValue, alpha: alpha)
    }
    
    public class func hexColorWith(hexString: String) -> UIColor {
        return hexColorWith(hexString: hexString, alpha: 1)
    }
}


extension UIColor {
    // 获取R,G,B,A的颜色值
    public func getRGBA() ->(a: CGFloat, r: CGFloat, g:CGFloat, b:CGFloat) {
        var r : CGFloat = 0,
        g : CGFloat = 0,
        b : CGFloat = 0,
        a : CGFloat = 0;
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (a,r,g,b)
    }
}
