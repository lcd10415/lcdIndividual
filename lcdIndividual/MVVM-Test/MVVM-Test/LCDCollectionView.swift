//
//  LCDCollectionView.swift
//  MVVM-Test
//
//  Created by Liuchaodong on 2018/3/8.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit
class LCDCollectionView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{
    var imageArr: [LCDCollectionModel] = []
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50,height: 50)
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        //设置最小行间距
        layout.minimumLineSpacing = 10;
        //设置垂直间距
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame:self.bounds,collectionViewLayout:layout)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor.white
            return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.collectionView)
        self.collectionView.register(LCDCollectionViewCell.self, forCellWithReuseIdentifier: "LCDCollectionViewCell")
//        self.collectionView.register(LCDCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "LCDCollectionViewHeader")
//        self.collectionView.register(LCDCollectionViewFooter.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "LCDCollectionViewFooter")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.imageArr.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let identifier = "LCDCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! LCDCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.model = self.imageArr[indexPath.row]
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击了\(indexPath.row)个item")
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LCDCollectionViewHeader", for: indexPath)
            headerView.backgroundColor = UIColor.white
            let titleLab = UILabel(frame: headerView.bounds)
            titleLab.text = "第\(indexPath.section)个分区的区头"
            headerView.addSubview(titleLab)
            return headerView
        } else if kind == UICollectionElementKindSectionFooter  {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LCDCollectionViewFooter", for: indexPath)
            footerView.backgroundColor = UIColor.white
            let titleLab = UILabel(frame: footerView.bounds)
            titleLab.text = "第\(indexPath.section)个分区的区尾"
            footerView.addSubview(titleLab)
            return footerView
        }
        return UICollectionReusableView()
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
}





































