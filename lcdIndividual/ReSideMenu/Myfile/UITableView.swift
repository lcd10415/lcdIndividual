//
//  UITableView.swift
//  ReSideMenu
//
//  Created by Liuchaodong on 2018/1/4.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueCellAndLoadContent(_ indexPath:IndexPath,tableView: UITableView?,controller: UIViewController?,identifier:String) -> ResideCell {
        let cell  = self.dequeueReusableCell(withIdentifier: identifier) as! ResideCell
        cell.title = ""
        cell.cellData?.cellIdentifier = identifier
        cell.indexPath = indexPath
        cell.controller = controller
        return cell
    }
}
