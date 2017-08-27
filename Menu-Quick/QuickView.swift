//
//  QuickView.swift
//  Menu-Quick
//
//  Created by 赵恒 on 2017/8/27.
//  Copyright © 2017年 Mooshroom. All rights reserved.
//

import UIKit
import SnapKit

enum CellIdentifier: String {
    case identifier1
    case identifier2
}
enum HeaderIdentifier: String {
    case headerIdentifier
}

//MARK: ------- QuickView ------
class QuickView: UIView
{
    lazy var collectionView: UICollectionView = {
        var collection = UICollectionView(frame: self.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.allowsMultipleSelection = false
        collection.allowsSelection = true
        collection.backgroundColor = .white
        collection.bounces = true
        collection.showsVerticalScrollIndicator = false
        collection.register(QuickSettingCell.classForCoder(), forCellWithReuseIdentifier: CellIdentifier.identifier1.rawValue)
        collection.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderIdentifier.headerIdentifier.rawValue)
        return collection
    }()
    
    var eventPressedClosure: ((String) -> Void)?
    var showHideNavClosure: ((Bool) -> Void)?
    
    init(frame: CGRect, pressdClosure:((_ rawValue: String) -> Void)?, showNavClosure:((_ flag: Bool) -> Void)?)
    {
        if let tempPressdClosure = pressdClosure {
            eventPressedClosure = tempPressdClosure
        }
        if let tempShowHideNavClosure = showNavClosure {
            showHideNavClosure = tempShowHideNavClosure
        }
        super.init(frame: frame)
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: ------- UICollectionViewDataSource ------
extension QuickView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return QuickSetting.items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.identifier1.rawValue, for: indexPath) as! QuickSettingCell
        let text = QuickSetting.items[indexPath.row]
        let color = QuickSetting.colors[indexPath.row % QuickSetting.colors.count]
        cell.updateTheCell(text: text, color: color)
        return cell
    }
    // 头视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderIdentifier.headerIdentifier.rawValue, for: indexPath)
        if (kind == UICollectionElementKindSectionHeader) {
            
            let headImageView = UIImageView(image: UIImage(named: "my_header.jpg"))
            headImageView.layer.cornerRadius = CGFloat(20.px)
            headImageView.layer.masksToBounds = true
            reusableView.addSubview(headImageView)
            
            let titleLabel = UILabel()
            titleLabel.text = Quick.menuQuickNavTitle
            titleLabel.font = UIFont.systemFont(ofSize: CGFloat(40.px))
            reusableView.addSubview(titleLabel)
            
            let lineView = UIView()
            lineView.backgroundColor = UIColor(red:0.72, green:0.72, blue:0.72, alpha:1.00)
            reusableView.addSubview(lineView)
            
            let padding = 20.px
            
            headImageView.snp.makeConstraints({ (make) in
                make.left.equalTo(reusableView).offset(padding)
                make.centerY.equalTo(reusableView)
                make.size.equalTo(CGSize(width: 40.px, height: 40.px))
            })
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalTo(headImageView.snp.right).offset(padding)
                make.right.equalTo(reusableView).offset(-padding)
                make.height.equalTo(40.px)
                make.centerY.equalTo(reusableView)
            })
            lineView.snp.makeConstraints({ (make) in
                make.left.right.equalTo(reusableView).offset(0)
                make.height.equalTo(1)
                make.top.equalTo(reusableView.snp.bottom).offset(-2)
            })
            
        }
        return reusableView
    }
}

//MARK: ------- UICollectionViewDelegate ------
extension QuickView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        cell.backgroundColor = UIColor.blue
        guard let closure = eventPressedClosure else {
            return
        }
        let rawValue = QuickSetting.settingItems[indexPath.row]
        closure(rawValue)
    }
}

//MARK: ------- UICollectionViewDelegateFlowLayout ------
extension QuickView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: Quick.screenWidth-40.px, height: 50.px)
        return CGSize(width: Quick.screenWidth, height: 64.px)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let padding = CGFloat(20.px)
        return UIEdgeInsets(top: padding, left: 0, bottom: 0, right: 0)
    }
    // 行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return CGFloat(0)
    }
    // 头高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSize(width: Quick.screenWidth, height: 120.px)
    }
}


extension QuickView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        if offset.y >= 75 {
            guard let closure = showHideNavClosure else {
                return
            }
            closure(true)
        } else {
            guard let closure = showHideNavClosure else {
                return
            }
            closure(false)
        }
    }
    
}


//MARK: ------- QuickCollectionCell ------
class QuickSettingCell: UICollectionViewCell {

    lazy var titleLabel: UILabel = {
        var lable = UILabel()
        lable.textColor = UIColor.white
        lable.font = UIFont.systemFont(ofSize: CGFloat(15.px))
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.layer.cornerRadius = 5
//        self.layer.masksToBounds = true
//        if let layer = Quick.grandientFromLTR(colors: [
//            UIColor(red:0.33, green:0.33, blue:0.33, alpha:1.00).cgColor,
//            UIColor(red:0.53, green:0.53, blue:0.53, alpha:1.00).cgColor
//            ], bounds: self.contentView.bounds) {
//            self.contentView.layer.addSublayer(layer)
//        }
    }
    
    override func layoutSubviews() {
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10.px)
            make.centerY.equalTo(self.contentView)
        }
    }
    
    func updateTheCell(text: String?, color: UIColor) {
        guard let title = text else {
            return
        }
        titleLabel.text = title
        self.contentView.backgroundColor = color
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


