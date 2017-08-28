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
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.hideBottomHairLine()
        self.navigationItem.title = Quick.menuQuickNavTitle
    }
}

extension QuickViewController {
    func open(_ rawValue: String) {
        Quick.open(url: QuickSetting.url(rawValue: rawValue))
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

