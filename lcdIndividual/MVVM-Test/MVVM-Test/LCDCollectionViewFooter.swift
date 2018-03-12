//
//  LCDCollectionViewFooter.swift
//  MVVM-Test
//
//  Created by Liuchaodong on 2018/3/8.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit
class LCDCollectionViewFooter: UICollectionReusableView {
    var imageName:String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
