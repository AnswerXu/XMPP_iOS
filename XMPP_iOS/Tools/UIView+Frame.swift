//
//  UIView+Extention.swift
//
//  Created by 澳蜗科技 on 2017/4/14.
//  Copyright © 2017年 AnswerXu. All rights reserved.
//
import UIKit

extension UIView{
    
    public var x: CGFloat{
        get{
            return self.frame.origin.x
        }
    }
    
    public var y: CGFloat{
        get{
            return self.frame.origin.y
        }
    }
    
    // 右边界的x值
    public var rightX: CGFloat{
        get{
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    // 下边界的y值
    public var bottomY: CGFloat{
        get{
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    public var centerX: CGFloat{
        get{
            return self.center.x
        }
    }
    
    public var centerY: CGFloat{
        get{
            return self.center.y
        }
    }
    
    public var width: CGFloat{
        get{
            return self.frame.width
        }
    }
    
    public var height: CGFloat{
        get{
            return self.frame.height
        }
    }
    
    public var origin: CGPoint{
        get{
            return self.frame.origin
        }
    }
    
    public var size: CGSize{
        get{
            return self.frame.size
        }
    }
    
    @discardableResult
    public func x(_ offset: CGFloat) -> Self {
        var r = self.frame
        r.origin.x = offset
        self.frame = r
        return self
    }
    
    @discardableResult
    public func rightX(_ offset: CGFloat) -> Self {
        var r = self.frame
        r.origin.x = offset - self.frame.size.width
        self.frame = r
        return self
    }
    
    @discardableResult
    public func y(_ offset: CGFloat) -> Self {
        var r = self.frame
        r.origin.y = offset
        self.frame = r
        return self
    }
    
    @discardableResult
    public func bottomY(_ offset: CGFloat) -> Self {
        var r = self.frame
        r.origin.y = offset - self.frame.size.height
        self.frame = r
        return self
    }
    
    @discardableResult
    public func center(_ x: CGFloat, y: CGFloat) -> Self {
        self.center = CGPoint.init(x: x, y: y)
        return self
    }
    @discardableResult
    public func centerX(_ offset: CGFloat) -> Self {
        self.center = CGPoint.init(x: offset, y: self.center.y)
        return self
    }
    
    @discardableResult
    public func centerY(_ offset: CGFloat) -> Self {
        self.center = CGPoint.init(x: self.center.x, y: offset)
        return self
    }
    
    @discardableResult
    public func width(_ offset: CGFloat) -> Self {
        self.frame.size.width = offset
        return self
    }
    
    @discardableResult
    public func height(_ offset: CGFloat) -> Self {
        self.frame.size.height = offset
        return self
    }
    
    @discardableResult
    public func origin(_ x: CGFloat, y: CGFloat) -> Self {
        self.frame.origin.x = x
        self.frame.origin.y = y
        return self
    }
    
    @discardableResult
    public func size(_ width: CGFloat, height: CGFloat) -> Self {
        self.frame.size = CGSize.init(width: width, height: height)
        return self
    }
    
    @discardableResult
    public func bounds(_ width: CGFloat, height: CGFloat) -> Self {
        self.bounds = CGRect.init(origin: .zero,
                                  size: CGSize.init(width: width,
                                                    height: height))
        return self
    }
    
    @discardableResult
    public func backgroundColor(_ color: UIColor?) -> Self {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult
    public func frame(_ x: CGFloat, y: CGFloat,
                      width: CGFloat, height: CGFloat) -> Self {
        self.frame = CGRect.init(x: x, y: y, width: width, height: height)
        return self
    }
    
    
    @discardableResult
    public func tag(_ num: Int) -> Self {
        self.tag = num
        return self
    }
    
    @discardableResult
    public func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }
    
    @discardableResult
    public func isUserInteractionEnabled(_ enable: Bool) -> Self{
        self.isUserInteractionEnabled = enable
        return self
    }
}


extension UIView {
    
    @discardableResult
    public func addToSuperView(_ view: UIView) -> Self {
        view.addSubview(self)
        return self
    }
    
    // 清空所有子视图
    public func removeAllFromSuperview() {
        for v in subviews {
            v.removeFromSuperview()
        }
    }
    
    // 获取响应链中的控制器对象
    public func viewController_self() -> UIViewController?{
        var responder : UIResponder? = self
        while responder != nil {
            if (responder?.isKind(of: UIViewController.self)) == true {
                return responder as? UIViewController
            }
            responder = responder?.next
        }
        return nil
    }
    
    // 获取响应链中的tableView对象
    public func tableView_self() -> UITableView? {
        var responder : UIResponder? = self
        while responder != nil {
            if (responder?.isKind(of: UITableView.self)) == true {
                return responder as? UITableView
            }
            responder = responder?.next
        }
        return nil
    }
    
    // 获取响应链中对应的响应者
    public func getResponder_super(responderClass: Swift.AnyClass?) -> AnyObject? {
        guard let responderClass = responderClass else {
            return nil
        }
        var responder : UIResponder? = self
        while responder != nil {
            if (responder?.isKind(of: responderClass.self)) == true {
                return responder.self
            }
            responder = responder?.next
        }
        return nil
    }
    
    // 获取视图内容生成的图像
    public func getContentImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, true, 0)
        
        var newImage : UIImage? = nil
        if self.drawHierarchy(in: self.bounds, afterScreenUpdates: true) {
            newImage = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return newImage
    }
}
