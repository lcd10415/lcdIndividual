//
//  LCDBasicController.swift
//  ReSideMenu
//
//  Created by Liuchaodong on 2018/1/5.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit

class LCDBasicController: UIViewController {
    var frame:CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.extendedLayoutIncludesOpaqueBars = true
        
    }
    convenience init(frame:CGRect) {
        self.init(frame:frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
