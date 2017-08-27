//
//  Quick.swift
//  Menu-Quick
//
//  Created by 赵恒 on 2017/8/27.
//  Copyright © 2017年 Mooshroom. All rights reserved.
//

import Foundation
import UIKit

class Quick {
    static var screenWidth: Double {
        return Double(UIScreen.main.bounds.width)
    }
    
    // 尝试打开链接
    class func canOpen(url: URL) -> Bool {
        return UIApplication.shared.canOpenURL(url)
    }
    
    // 打开链接
    class func open(url: URL) {
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
        }
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
    class var menuQuickNavTitle: String {
        return "Menu-Quick"
    }
}

extension Double {
   var px: Double {
        let power = Double(UIScreen.main.bounds.width) / 375.0
        return self * power
    }
}
