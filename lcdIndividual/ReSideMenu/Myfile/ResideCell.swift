//
//  ResideCell.swift
//  ReSideMenu
//
//  Created by Liuchaodong on 2018/1/4.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit
protocol CustomCellDelegate :class{
    
    //处理ResideCell需要传入事件的数据
    func customCell(_ cell: ResideCell?,event:AnyObject?)
}

class ResideCell: UITableViewCell {
    
    var title      : String?
    var cellData : CellData?
    var indexPath  : IndexPath?
    weak var controller: UIViewController?
    var image1         : UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        image1 = UIImageView(frame:CGRect(x:10,y:10,width:40,height:40))
    }
    //类方法
    class func RegisterTo(_ tableView: UITableView,cellReuseIdentifier: String?) {
        tableView.register(self, forCellReuseIdentifier: ((cellReuseIdentifier != nil) ? cellReuseIdentifier!:"CELL"))
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
