//
//  QuickViewController.swift
//  Menu-Quick
//
//  Created by 赵恒 on 2017/8/27.
//  Copyright © 2017年 Mooshroom. All rights reserved.
//

import UIKit

class QuickViewController: UIViewController {
    
    lazy var quickView: QuickView = {
        let view = QuickView(frame: self.view.bounds, pressdClosure: { (rawValue) in
            self.open(rawValue)
        })
        return view
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        stepNavigation()
        self.view.addSubview(quickView)
    }
}

extension QuickViewController {
    func stepNavigation() {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.hideBottomHairLine()
        self.navigationItem.title = Quick.menuQuickNavTitle
    }
}

extension QuickViewController {
    func open(_ rawValue: String) {
        if !Quick.open(url: QuickSetting.url(rawValue: rawValue)) {
            return
        }
        let count = Quick.getCountsFromKey(key: rawValue)
        Quick.saveCountsFromKey(key: rawValue, value: count + 1)
        reloadCollection()
    }
}
extension QuickViewController {
    // 刷新collection
    func reloadCollection() {
        quickView.reloadCollection()
    }
    
}

