//
//  LCDCollectionViewCell.swift
//  MVVM-Test
//
//  Created by Liuchaodong on 2018/3/8.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit
class LCDCollectionViewCell: UICollectionViewCell {
    var imageName:UIImageView!
    var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageName = UIImageView(frame: CGRect(x:0,y:0,width:self.bounds.width,height:self.bounds.height))
        self.contentView.addSubview(imageName)
        
        self.title = UILabel(frame:CGRect(x:0,y:10,width:self.bounds.width,height:30))
        self.title.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2)
        self.title.textAlignment = .center;
        self.title.textColor = UIColor.black
        self.title.font = UIFont.systemFont(ofSize: 12)
        self.contentView.addSubview(title)
        self.contentView.bringSubview(toFront: title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var _model: LCDCollectionModel?
    var model: LCDCollectionModel{
        set(newValue){
            _model = newValue
            self.imageName.image = UIImage(named: newValue.imageName)
            self.title.text = newValue.title
        }
        get{
            return _model!
        }
    }
    
    
}
