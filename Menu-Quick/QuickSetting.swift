//
//  QuickSetting.swift
//  Menu-Quick
//
//  Created by 赵恒 on 2017/8/26.
//  Copyright © 2017年 Mooshroom. All rights reserved.
//

import Foundation
import UIKit

class QuickSetting {
    enum SettingEnum: String {
        // 无线局域网
        case WIFI = "WIFI"
        // 蓝牙
        case Bluetooth = "Bluetooth"
        // 移动网络
        case MobileNet = "MOBILE_DATA_SETTINGS_ID"
        // 个人热点
        case PersonHot = "INTERNET_TETHERING"
        // 运营商
        case Carrier = "Carrier"
        // 通知
        case Notification = "NOTIFICATIONS_ID"
        // 通用
        case General = "General"
    }
    class var settingItems: [String] {
        return [
            SettingEnum.WIFI.rawValue,
            SettingEnum.Bluetooth.rawValue,
            SettingEnum.MobileNet.rawValue,
            SettingEnum.PersonHot.rawValue,
            SettingEnum.Carrier.rawValue,
            SettingEnum.Notification.rawValue,
            SettingEnum.General.rawValue,
        ]
    }
    class var items: [String] {
        return [
            "WIFI",
            "蓝牙",
            "移动网络",
            "个人热点",
            "运营商",
            "通知",
            "通用",
        ]
    }

    class var details: [String] {
        return [
            "WIFI的相关设置 - WIFI",
            "手机蓝牙/车载蓝牙 - Bluetooth",
            "手机2G/3G/4G网络设置 - MobileNet",
            "个人移动热点，可以用PC链接上网 - PersonHot",
            "中国移动、联通、电信 - Carrier",
            "系统通知、弹窗、下拉的通知条选项 - NotificationCenter",
            "通用、关于本机、描述文件等配置信息 - General",
        ]
    }
    class var colors: [UIColor] {
        return [
            UIColor(red:0.96, green:0.32, blue:0.31, alpha:1.00),
            UIColor(red:0.44, green:0.77, blue:0.91, alpha:1.00),
            UIColor(red:0.92, green:0.81, blue:0.40, alpha:1.00),
            UIColor(red:0.33, green:0.77, blue:0.71, alpha:1.00),
            UIColor(red:0.98, green:0.69, blue:0.69, alpha:1.00),
            UIColor(red:0.00, green:0.63, blue:0.69, alpha:1.00)
        ]
    }
    class var prefix: String {
        get {
            if #available(iOS 10, *) {
                return "App-Prefs:root="
            } else {
                return "prefs:root="
            }
        }
    }
    class func url(rawValue: String) -> URL{
        return URL(string: prefix + rawValue)!
    }
    
}
