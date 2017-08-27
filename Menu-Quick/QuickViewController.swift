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
        }, showNavClosure: { (flag) in
            self.showNav(flag)
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
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        let headImageView = UIImageView(image: UIImage(named: "my_header.jpg"))
        headImageView.layer.cornerRadius = CGFloat(10.px)
        headImageView.layer.masksToBounds = true
        self.navigationController?.navigationBar.addSubview(headImageView)
        
        let titleLabel = UILabel()
        titleLabel.text = Quick.menuQuickNavTitle
        titleLabel.font = UIFont.systemFont(ofSize: CGFloat(17.px))
        self.navigationController?.navigationBar.addSubview(titleLabel)
        
        let padding = 10.px
        headImageView.snp.makeConstraints({ (make) in
            make.centerX.equalTo((self.navigationController?.navigationBar)!).offset(-padding*5)
            make.centerY.equalTo((self.navigationController?.navigationBar)!)
            make.size.equalTo(CGSize(width: 20.px, height: 20.px))
        })
        titleLabel.snp.makeConstraints({ (make) in
            make.left.equalTo(headImageView.snp.right).offset(padding)
            make.height.equalTo(17.px)
            make.centerY.equalTo((self.navigationController?.navigationBar)!)
        })
    }
    func showNav(_ flag: Bool) {
        if (flag) {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
}

extension QuickViewController {
    func open(_ rawValue: String) {
        Quick.open(url: QuickSetting.url(rawValue: rawValue))
    }
}
