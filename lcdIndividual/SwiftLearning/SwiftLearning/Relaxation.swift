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
    let data = LoadPlist().readPlistFile(fileName: "Data")
    private let typeCellID = "TypeCellID"
    @IBOutlet weak var _layout: UICollectionViewFlowLayout!
    /*
     1.collectionView每次需要重新布局(初始化,layout 被设置为invalidated ...)的时候会首先调用这个方法prepareLayout().在cell比较少的情况下，一般可以用这个方法计算好所有的cell的布局并且缓存下来，在需要的时候直接取相应的值.
     2.然后会调用layoutAttributesForElementsInRect(rect: CGRect)方法获取rect范围内的cell的所有布局，这个rect和collection的bounds不一样，size可能比collectionView大些，为了缓冲。 func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]?
     3. 当collectionView的bounds变化的时候会调用shouldInvalidateLayoutForBoundsChange(newBounds: CGRect)这个方法
     4. 需要设置collectionView 的滚动范围 collectionViewContentSize()
     5. 以下方法, Apple建议我们也重写, 返回正确的自定义对象的布局,因为有时候当collectionView执行一些操作(delete insert reload)等系统会调用这些方法获取布局, 如果没有重写, 可能发生意想不到的效果
     6. 这个方法是当collectionView将停止滚动的时候调用, 我们可以重写它来实现, collectionView停在指定的位置(比如照片浏览的时候, 你可以通过这个实现居中显示照片...)
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupSpace()
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

