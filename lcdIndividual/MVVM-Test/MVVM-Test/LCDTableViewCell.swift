//
//  LCDTableViewCell.swift
//  MVVM-Test
//
//  Created by Liuchaodong on 2018/3/7.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit
class LCDTableViewCell: UITableViewCell {
    weak var lab: UILabel!
    weak var imgView: UIImageView!
    weak var subLab: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let imageView = UIImageView(frame: CGRect(x:5,y:5,width:50,height:50))
        self.contentView.addSubview(imageView)
        self.imgView = imageView
        
        let lab = UILabel(frame: CGRect(x:imageView.frame.maxX+10,y:15,width:self.bounds.width,height:20))
        lab.font = UIFont.systemFont(ofSize: 18.0)
        self.contentView.addSubview(lab)
        self.lab = lab
        
        let subLab = UILabel(frame:CGRect(x:imageView.frame.maxX+10,y:40,width:self.bounds.width,height:13))
        subLab.font = UIFont.systemFont(ofSize: 13)
        subLab.numberOfLines = 0;
//        subLab.sizeToFit()
//        let size = subLab.sizeThatFits(CGSize(width:self.bounds.width,height:CGFloat(MAXFLOAT)))
//        subLab.frame = CGRect(x:imageView.frame.maxX+10,y:40,width:size.width,height:size.height)
        self.contentView.addSubview(subLab)
        self.subLab = subLab
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    class func cellWithTableView(tableView: UITableView) -> LCDTableViewCell {
        let identifier = "LCDCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = LCDTableViewCell.init(style: .default, reuseIdentifier: identifier)
        }
        return cell as! LCDTableViewCell
    }
    var _model:LCDCellModel?
    
    var model: LCDCellModel{
        
        set(newValue){
            _model = newValue
            self.imgView.image = UIImage(named:newValue.image)
            self.lab.text = newValue.title
            self.subLab.text = newValue.subTitle
            
        }
        get{
            return _model!
        }
    }
    
}
