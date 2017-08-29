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
    static var items: [(String, String, String, UInt)] {
        return [
            ("WIFI", "WIFI的相关设置 - WIFI", SettingEnum.WIFI.rawValue, Quick.getCountsFromKey(key: SettingEnum.WIFI.rawValue)),
            ("蓝牙", "手机蓝牙/车载蓝牙 - Bluetooth", SettingEnum.Bluetooth.rawValue, Quick.getCountsFromKey(key: SettingEnum.Bluetooth.rawValue)),
            ("移动网络", "手机2G/3G/4G网络设置 - MobileNet", SettingEnum.MobileNet.rawValue, Quick.getCountsFromKey(key: SettingEnum.MobileNet.rawValue)),
            ("个人热点", "个人移动热点，可以用PC链接上网 - PersonHot", SettingEnum.PersonHot.rawValue, Quick.getCountsFromKey(key: SettingEnum.PersonHot.rawValue)),
            ("运营商", "中国移动、联通、电信 - Carrier", SettingEnum.Carrier.rawValue, Quick.getCountsFromKey(key: SettingEnum.Carrier.rawValue)),
            ("通知", "系统通知、弹窗、下拉的通知条选项 - NotificationCenter", SettingEnum.Notification.rawValue, Quick.getCountsFromKey(key: SettingEnum.Notification.rawValue)),
            ("通用", "通用、关于本机、描述文件等配置信息 - General", SettingEnum.General.rawValue, Quick.getCountsFromKey(key: SettingEnum.General.rawValue))
        ].sorted(by: { (s1, s2) -> Bool in
            return s1.2 > s2.2
        })
    }
    static var prefix: String {
        get {
            if #available(iOS 10, *) {
                return "App-Prefs:root="
            } else {
                return "prefs:root="
            }
        }
    }
    static func url(rawValue: String) -> URL{
        return URL(string: prefix + rawValue)!
    }
    
}
