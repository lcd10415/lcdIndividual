//
//  LCDHeaderView.swift
//  MVVM-Test
//
//  Created by Liuchaodong on 2018/3/7.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit
class LCDHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let label = UILabel(frame: CGRect(x:0,y:0,width:self.frame.size.width,height:100))
        label.text = "这是头部视图"
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.gray
        self.addSubview(label)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
