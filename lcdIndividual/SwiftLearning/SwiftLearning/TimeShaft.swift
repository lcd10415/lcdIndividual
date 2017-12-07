//
//  TimeShaft.swift
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/6/29.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

import UIKit

class TimeLineCell: UITableViewCell{
    var timeLineIcon: UIImageView!
    //费用显示文本标签
    var costLabel: UILabel!
    //消费时间文本标签
    var dateTimeLabel: UILabel!
    //消费条目文本标签
    var titleLabel: UILabel!
    //备注标签容器
    var containView: UIView!
    //备注显示文本标签
    var appendixLabel: UILabel!
    //图标上半部分的时间线
    var forepartTimeLineLabel: UIView!
    //图标下半部分的时间线
    var backpartTimeLineLabel: UIView!
    //时间线离左右的横向间距
    let horizontalGap: CGFloat = 25
    var hasAppendix:Bool = false{
        didSet
        {
//            重写该属性值
            UITableViewAutomaticDimension
        }
    }
    
    
}
