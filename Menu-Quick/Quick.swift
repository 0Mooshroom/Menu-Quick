//
//  Quick.swift
//  Menu-Quick
//
//  Created by 赵恒 on 2017/8/27.
//  Copyright © 2017年 Mooshroom. All rights reserved.
//

import Foundation
import UIKit
import YYCache

let counts = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!

public enum NotificationName: String {
    case reloadCollection
}

class Quick {
    // 屏幕宽度
    static var screenWidth: Double {
        return Double(UIScreen.main.bounds.width)
    }
    
    static var colors: [UIColor] {
        return [
            UIColor(red:0.96, green:0.32, blue:0.31, alpha:1.00),
            UIColor(red:0.44, green:0.77, blue:0.91, alpha:1.00),
            UIColor(red:0.33, green:0.77, blue:0.71, alpha:1.00)
        ]
    }
    
    // 尝试打开链接
    static func canOpen(url: URL) -> Bool {
        return UIApplication.shared.canOpenURL(url)
    }
    
    // 打开链接
    static func open(url: URL) -> Bool{
        if canOpen(url: url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: ({
                    (isSuccess) in
                    if isSuccess {
                        print("jump to \(url) is success")
                    } else {
                        print("jump to \(url) is failure")
                    }
                }))
            } else {
                UIApplication.shared.openURL(url)
            }
            return true
        }
        return false
    }
    
    // 渐变从左至右
    static func grandientFromLTR(colors: [CGColor]?, bounds: CGRect) -> CAGradientLayer? {
        guard let gColors = colors else {
            return nil
        }
        let grandientLayer = CAGradientLayer()
        grandientLayer.colors = gColors
        grandientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        grandientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        grandientLayer.frame = bounds
        return grandientLayer
    }
    
    // nav标题
    static var menuQuickNavTitle: String {
        return "Shortcut-快捷方式"
    }
    
    
    // 存储功能使用过的次数
    static var cachePath: String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    }
    static func saveCountsFromKey(key: String, value: UInt) {
        let cache = YYKVStorage(path: counts, type: YYKVStorageType.sqLite)
        let data = String(value).data(using: .utf8)
        if let dt = data {
            cache?.saveItem(withKey: key, value: dt)
        }
    }
    static func getCountsFromKey(key: String) -> UInt {
        let cache = YYKVStorage(path: counts, type: YYKVStorageType.sqLite)
        guard let dt = cache?.getItemValue(forKey: key) else {
            return 0
        }
        guard let str = String(data: dt, encoding: .utf8) else {
            return 0
        }
        return UInt(str)!
    }
    static func removeCounts() {
        let cache = YYKVStorage(path: counts, type: YYKVStorageType.sqLite)
        cache?.removeAllItems()
    }
    
    
    // 返回根据数字映射的颜色
    static func getColorWithNumber(number: UInt) -> UIColor? {
        if number <= 50 {
            return colors[2]
        }
        if number <= 150 {
            return colors[1]
        }
        return colors[0]
    }
    
}

extension Double {
   var px: Double {
        let power = Double(UIScreen.main.bounds.width) / 375.0
        return self * power
    }
}

extension UINavigationBar {
    
    func hideBottomHairLine() {
        let navigationBarImageView = hairLineImageViewInNavigationBar(view: self)
        navigationBarImageView?.isHidden = true
    }
    
    func showBottomHairLine() {
        let navigationBarImageView = hairLineImageViewInNavigationBar(view: self)
        navigationBarImageView?.isHidden = false
    }
    
    func hairLineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subViews = (view.subviews as [UIView])
        for subView: UIView in subViews {
            if let imageView: UIImageView = hairLineImageViewInNavigationBar(view: subView) {
                return imageView
            }
        }
        return nil
    }
}

