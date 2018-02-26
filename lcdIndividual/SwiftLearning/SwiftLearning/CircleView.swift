//
//  CircleView.swift
//  SwiftLearning
//
//  Created by Liuchaodong on 2018/1/19.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit

class CircleView: UIView {
    convenience init(frame: CGRect,lineWidth: CGFloat,lineColor: UIColor,clockWise: Bool) {
        self.init(frame: frame)
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        self.clockWise = clockWise
    }
    var lineWidth: CGFloat{
        get{
            return 0
        }
        set(newValue){
            
        }
    }
    
    var lineColor: UIColor{
        get{
            return UIColor.white
        }
        set{
            
        }
    }
    
    var clockWise = true
    
    
    
}
