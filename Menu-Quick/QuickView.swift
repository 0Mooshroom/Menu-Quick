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
        collection.delaysContentTouches = false
        collection.register(QuickSettingCell.classForCoder(), forCellWithReuseIdentifier: CellIdentifier.identifier1.rawValue)
        collection.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderIdentifier.headerIdentifier.rawValue)
        return collection
    }()
    
    var eventPressedClosure: ((String) -> Void)?
    
    init(frame: CGRect, pressdClosure:((_ rawValue: String) -> Void)?)
    {
        if let tempPressdClosure = pressdClosure {
            eventPressedClosure = tempPressdClosure
        }
        
        super.init(frame: frame)
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: ------- 操作 ------
extension QuickView {
    func reloadCollection() {
        self.collectionView.reloadData()
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
        let text = QuickSetting.items[indexPath.row].0
        let detail = QuickSetting.items[indexPath.row].1
        let count = QuickSetting.items[indexPath.row].3
        cell.updateTheCell(text: text, detail: detail, count: count)
        return cell
    }
}

//MARK: ------- UICollectionViewDelegate ------
extension QuickView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        guard let closure = eventPressedClosure else {
            return
        }
        let rawValue = QuickSetting.items[indexPath.row].2
        closure(rawValue)
    }
}

//MARK: ------- UICollectionViewDelegateFlowLayout ------
extension QuickView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Quick.screenWidth, height: 64.px)
    }
    // 行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return CGFloat(0)
    }
}

//MARK: ------- QuickCollectionCell ------
class QuickSettingCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: CGFloat(15.px), weight: UIFontWeightBold)
        return label
    }()
    lazy var detailLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: CGFloat(11.px))
        return label
    }()
    lazy var lineView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.00)
        return view
    }()
    lazy var countsLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: CGFloat(11.px))
        label.textAlignment = .center
        label.layer.cornerRadius = CGFloat(10.px)
        label.layer.masksToBounds = true
        return label
    }()
    
    var countsLabelWidht: Double = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailLabel)
        self.contentView.addSubview(lineView)
        self.contentView.addSubview(countsLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10.px)
            make.top.equalTo(self.contentView).offset(10.px)
        }
        countsLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(-20.px)
            make.width.equalTo(20.px)
            make.height.equalTo(20.px)
            make.top.equalTo(titleLabel)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5.px)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10.px)
            make.bottom.equalTo(self.contentView).offset(-1)
            make.size.equalTo(CGSize(width: Quick.screenWidth, height: 0.5))
        }
    }
    
    func updateTheCell(text: String?, detail: String? = nil, count: UInt) {
        if let title = text {
            titleLabel.text = title
        }
        if let d = detail {
            detailLabel.text = d
        }
        countsLabel.text = String(count)
        countsLabel.backgroundColor = Quick.getColorWithNumber(number: count)
        switch count {
        case 0..<100 :
            countsLabelWidht = 20
        case 100..<1000:
            countsLabelWidht = 30
        default:
            countsLabelWidht = 40
        }
        countsLabel.snp.updateConstraints({ (make) in
            make.width.equalTo(countsLabelWidht)
        })
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


