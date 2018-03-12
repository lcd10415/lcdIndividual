//
//  LCDScrollHeader.swift
//  MVVM-Test
//
//  Created by Liuchaodong on 2018/3/8.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit
//滚动头部选择不同的控制器
class LCDScrollHeader: UIScrollView,UIScrollViewDelegate {
    var dataSource :[String] = []
    
    var scrollView: UIScrollView!
    
    init(frame: CGRect,parentVC:UIViewController,childVCs:[UIViewController]) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    
}
