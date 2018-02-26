//
//  String+StringHeight.swift
//  SwiftLearning
//
//  Created by Liuchaodong on 2018/1/22.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit

extension String{
    func heightWithStringAttributes(_ attributes: [String: AnyObject],fixedWidth: CGFloat) -> CGFloat {
        guard self.characters.count > 0 && fixedWidth > 0 else {
            return 0;
        }
        let size = CGSize(width: fixedWidth,height: CGFloat.greatestFiniteMagnitude)
        let text = self as NSString
        
//        ??
//        let rect = text.boundingRect(with: <#T##CGSize#>, options: <#T##NSStringDrawingOptions#>, attributes: <#T##[String : Any]?#>, context: <#T##NSStringDrawingContext?#>)
        
        return 0;
    }
}

extension UIView{
    var viewOrigin: CGPoint{
        get{ return frame.origin }
        set(newValue){
            var tmpFrame = frame
            tmpFrame.origin = newValue
            frame = tmpFrame
        }
    }
    var viewSize: CGSize{
        get{ return frame.size }
        set(newValue){
            var tmpFrame = frame
            tmpFrame.size = newValue
            frame = tmpFrame
        }
    }
    var x: CGFloat{
        get{return frame.origin.x }
        set{
            var tmpFrame = frame
            tmpFrame.origin.x = newValue
            frame = tmpFrame
        }
    }
    var width: CGFloat{
        get{ return frame.size.width}
        set{
            var tmpF = frame
            tmpF.size.width = newValue
            frame = tmpF
        }
    }
    
    var centerX: CGFloat{
        get{return center.x}
        set{
            center = CGPoint(x:newValue,y:center.y)
        }
    }
    var middleX: CGFloat{
        get{ return bounds.width/2 }
    }
    
    
    
}
