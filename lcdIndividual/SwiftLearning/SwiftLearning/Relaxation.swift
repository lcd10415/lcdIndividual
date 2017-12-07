//
//  Relaxation.swift
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/8/25.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

import UIKit

class TypeCell: UICollectionViewCell {
    
    @IBOutlet weak var _lblTitle: UILabel!
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        attributes.frame = CGRect(x:0,y:0,width: NSString(string:_lblTitle.text!).size(attributes: [NSFontAttributeName:_lblTitle.font]).width + 30,height:40)
        //计算cellSize，当前要求高度固定40，宽度自适应，现在根据字符串求出所需宽度+42，contentLabel相对cell左右各有20的空间
        //根据具体需求作灵活处理
        return attributes
    }
}


class Relaxation: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var _vTypeView: UICollectionView!
    let data = LoadPlist().readPlistFile(fileName: "Data") ?? []
    private let typeCellID = "TypeCellID"
    @IBOutlet weak var _layout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self._vTypeView.collectionViewLayout.
        _setupSpace()
//        Dream.psychosexualityFriend("xxx",25,"xxxx")
        print("11111111111")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return data.count
    }
    private func _setupSpace(){
        (self._vTypeView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: 120,height:40)
//        (self._vTypeView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 15
        (self._vTypeView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing = 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 80,height: 40)
        
        switch indexPath.row {
        case 0,1,2,5,6,7,8,9:
            size = CGSize(width: 120,height: 40)
        case 3:
            size = CGSize(width: 250,height: 40)
        case 4:
            size = CGSize(width: 160,height: 40)
        default:
            size = CGSize(width: 250,height: 40)
        }
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: typeCellID, for: indexPath) as! TypeCell
        cell._lblTitle.text = data[indexPath.row]
        return cell
    }
}

