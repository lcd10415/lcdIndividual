//
//  ViewController.swift
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/6/29.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

import UIKit
import AdSupport
import Photos
import Alamofire

class PB: UIViewController {
    
}
class ViewController: UIViewController,UIViewControllerTransitioningDelegate{

    @IBOutlet weak var _vCenter: UIView!
    var bouncePresent:TransitionAnimation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        应用程序的信息
//        let info = Bundle.main.infoDictionary!
//        let appName =  info["CFBundleDisplayName"]
//        let mainVersion = info["CFBundleShortVersionString"]
//        let miniVersion = info["CFBundleVersion"]
//        let iOSVersion = UIDevice.current.systemVersion
//        let identifier = UIDevice.current.identifierForVendor //设备的UDID
//        let systemName = UIDevice.current.systemName //设备名称
//        let model = UIDevice.current.model //设备型号
//        let modelName = UIDevice.current.model //设备具体型号
//        let localizedModel = UIDevice.current.localizedModel //设备区域化型号如A1533
//
//        //打印信息
//        print("程序名称：\(String(describing: appName))")
//        print("主程序版本号：\(String(describing: mainVersion))")
//        print("内部版本号：\(String(describing: miniVersion))")
//        print("iOS版本：\(iOSVersion)")
//        print("设备udid：\(String(describing: identifier))")
//        print("设备名称：\(systemName)")
//        print("设备型号：\(model)")
//        print("设备具体型号：\(modelName)")
//        print("设备区域化型号：\(localizedModel)")
//
//
//        //将Data装换[UInt8] bytes字节数组
//        let data = "liuchaodong".data(using: .utf8)!
//        let bytes = [UInt8](data)
////      1.   使用 [UInt8] 新的构造函数
//        print("\(bytes)")
////      2.  通过 Pointer 指针获取
//        let bytes2 = data.withUnsafeBytes{
//            [UInt8](UnsafeBufferPointer(start: $0, count: data.count))
//        }
//        print("\(bytes2)")
//
//        //删除字符串中前后多余的空格
//        let str = "       成都欢迎你         "
//        let filterStr = str.trimmingCharacters(in: .whitespaces)//去掉空格urlFragmentAllowed urlQueryAllowed whitespacesAndNewlines decimalDigits  letters  lowercaseLetters uppercaseLetters nonBaseCharacters alphanumerics
////        CharacterSet 里各个枚举类型的含义如下：
////        controlCharacters：控制符
////        whitespaces：空格
////        newlines：换行符
////        whitespacesAndNewlines：空格换行
////        decimalDigits：小数
////        letters：文字
////        lowercaseLetters：小写字母
////        uppercaseLetters：大写字母
////        nonBaseCharacters：非基础
////        alphanumerics：字母数字
////        decomposables：可分解
////        illegalCharacters：非法
////        punctuationCharacters：标点
////        capitalizedLetters：大写
////        symbols：符号
//        print("\(filterStr)")
//        let str1 =  "<<  www.baidu.com  >>"
//        //删除前后的<>
//        let characterSet1 = CharacterSet(charactersIn: "<>")
//        let str2 = str1.trimmingCharacters(in: characterSet1)
//        print("\(str2)")
//
//        //获取当前时间
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//        let currentDate = Date()
//        let currentDateStr = dateFormatter.string(from: currentDate)
//        print("\(currentDateStr)")
//
//        let OCRange = NSRange(location: 0,length: 3)
//        let str3 = "swift learning good good study day day up"
//
//        let range = str3.swiftRange(from: OCRange)
//        let subStr = str3.substring(with: range!)
//        print("截取后的字符：\(subStr)")
//
//        let adfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
//        print("广告标志符：\(adfa)")
//
//        //请求授权设置
//         let isAuth = requestAuthorize()
//        if isAuth {
//            print("授权成功")
//        }else{
//            print("授权失败")
//        }
//
//        loadImage()
//        setReplicatorLayer()
//        let view = MapView()
//        view.frame = CGRect(x:0,y:0,width:375,height:667);
//        self.view.addSubview(view)
        
//        let test = Test()
//        print("%@",test);
        
//        let imageProcess = ImageProcess()
//        imageProcess.frame = CGRect(x:0,y:0,width:100,height:100)
//        imageProcess.center = self.view.center
//        self.view.addSubview(imageProcess)
//        imageProcess.setupRadiusImage(1)
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        let db = DBTest()
        
//        let vc = UIViewController()
//        if #available(iOS 11.0, *) {
//            vc.navigationItem.largeTitleDisplayMode = .always
//        } else {
//            // Fallback on earlier versions
//        }
        
//        Alamofire.request("https://www.baidu.com").validate(statusCode: 200..<300).validate(contentType: ["text/html"]).responseData { (response) in
//            switch response.result{
//                case .success:
//                    print("successful")
//                case .failure(let error):
//                print(error)
//            }
//        }
        //Accept-Encoding 表示可接受的编码方式
//        Alamofire.download("https://httpbin.org/image/png").response { (response) in
//            print(response)
//
//        }
        let tab = TableViewFitHeight()
        let subLab = UILabel()
        subLab.numberOfLines = 0;
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byCharWrapping
        let dict  = [NSAttributedStringKey.font:self.subLab.font,NSAttributedStringKey.paragraphStyle:paragraphStyle] as [NSAttributedStringKey : Any]
        let rect = self.subLab.text?.boundingRect(with: self.subLab.bounds.size, options: .usesLineFragmentOrigin, attributes: dict, context: nil)
        subLab.frame = CGRect(x:0,y:40,width:(rect?.width)!,height:(rect?.height)!)
        subLab.font = UIFont.systemFont(ofSize: 13)
        
        self.view.addSubview(subLab)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //设置转场动画
    func setTransition() {
        self.bouncePresent = TransitionAnimation()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.bouncePresent;
    }
    
    //创建毛玻璃效果
    func makeBlur() {
        let bgView = UIImageView(image: UIImage(named:""))
        bgView.frame = self.view.bounds
        let blurEffect: UIBlurEffect = UIBlurEffect(style:.light)
        let blurView = UIVisualEffectView(effect:blurEffect)
        blurView.frame = CGRect(x:50,y:50,width:self.view.frame.width - 100,height: 200)
        self.view.addSubview(blurView)
    }
    
    
//    微信聊天群图标
    func loadImage(){
        //图标初始化
        let image0 = UIImage(named:"0")!
        let image1 = UIImage(named:"1")!
        let image2 = UIImage(named:"2")!
        let image3 = UIImage(named:"3")!
        let image4 = UIImage(named:"4")!
        let image5 = UIImage(named:"5")!
        let image6 = UIImage(named:"6")!
        let image7 = UIImage(named:"7")!
        let image8 = UIImage(named:"8")!
        
        //聊天群图标尺寸（长宽一样）
        let viewWH:CGFloat = 100
        
        //聊天群图标背景色（这里使用灰色，不设置的话则是透明的）
        let viewBgColor = UIColor(red: 0, green:0, blue: 0, alpha: 0.1)
        
        //imageView的圆角半径
        let corner = viewWH/20
        
        //创建生成各种情况的聊天群图标
        let imageView0 = UIImageView(frame: CGRect(x:5,y:20,width:viewWH,height:viewWH))
        imageView0.image = UIImage.groupIcon(wh:viewWH, images:[image0],
                                             bgColor:viewBgColor)
        imageView0.layer.masksToBounds = true
        imageView0.layer.cornerRadius = corner  //圆角
        self.view.addSubview(imageView0)
        
        let imageView1 = UIImageView(frame: CGRect(x:110,y:20,width:viewWH,height:viewWH))
        imageView1.image = UIImage.groupIcon(wh:viewWH, images:[image0,image1],
                                             bgColor:viewBgColor)
        imageView1.layer.masksToBounds = true
        imageView1.layer.cornerRadius = corner  //圆角
        self.view.addSubview(imageView1)
        
        let imageView2 = UIImageView(frame: CGRect(x:215,y:20,width:viewWH,height:viewWH))
        imageView2.image = UIImage.groupIcon(wh:viewWH, images:[image0,image1,image2],
                                             bgColor:viewBgColor)
        imageView2.layer.masksToBounds = true
        imageView2.layer.cornerRadius = corner  //圆角
        self.view.addSubview(imageView2)
        
        let imageView3 = UIImageView(frame: CGRect(x:5,y:125,width:viewWH,height:viewWH))
        imageView3.image = UIImage.groupIcon(wh:viewWH, images:[image0,image1,image2,
                                                                image3],
                                             bgColor:viewBgColor)
        imageView3.layer.masksToBounds = true
        imageView3.layer.cornerRadius = corner  //圆角
        self.view.addSubview(imageView3)
        
        let imageView4 = UIImageView(frame: CGRect(x:110,y:125,width:viewWH,height:viewWH))
        imageView4.image = UIImage.groupIcon(wh:viewWH, images:[image0,image1,image2,
                                                                image3,image4],
                                             bgColor:viewBgColor)
        imageView4.layer.masksToBounds = true
        imageView4.layer.cornerRadius = corner  //圆角
        self.view.addSubview(imageView4)
        
        let imageView5 = UIImageView(frame: CGRect(x:215,y:125,width:viewWH,height:viewWH))
        imageView5.image = UIImage.groupIcon(wh:viewWH, images:[image0,image1,image2,
                                                                image3,image4,image5],
                                             bgColor:viewBgColor)
        imageView5.layer.masksToBounds = true
        imageView5.layer.cornerRadius = corner  //圆角
        self.view.addSubview(imageView5)
        
        let imageView6 = UIImageView(frame: CGRect(x:5,y:230,width:viewWH,height:viewWH))
        imageView6.image = UIImage.groupIcon(wh:viewWH, images:[image0,image1,image2,
                                                                image3,image4,image5,
                                                                image6],
                                             bgColor:viewBgColor)
        imageView6.layer.masksToBounds = true
        imageView6.layer.cornerRadius = corner  //圆角
        self.view.addSubview(imageView6)
        
        let imageView7 = UIImageView(frame: CGRect(x:110,y:230,width:viewWH,height:viewWH))
        imageView7.image = UIImage.groupIcon(wh:viewWH, images:[image0,image1,image2,
                                                                image3,image4,image5,
                                                                image6,image7],
                                             bgColor:viewBgColor)
        imageView7.layer.masksToBounds = true
        imageView7.layer.cornerRadius = corner  //圆角
        self.view.addSubview(imageView7)
        
        let imageView8 = UIImageView(frame: CGRect(x:215,y:230,width:viewWH,height:viewWH))
        imageView8.image = UIImage.groupIcon(wh:viewWH, images:[image0,image1,image2,
                                                                image3,image4,image5,
                                                                image6,image7,image8],
                                             bgColor:viewBgColor)
        imageView8.layer.masksToBounds = true
        imageView8.layer.cornerRadius = corner  //圆角
        self.view.addSubview(imageView8)
    }
    
    func requestAuthorize()->Bool{
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            return true
            
        case .notDetermined:
            // 请求授权
            PHPhotoLibrary.requestAuthorization({ (status) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    _ = self.requestAuthorize()
                })
            })
            
        default: ()
        DispatchQueue.main.async(execute: { () -> Void in
            let alertController = UIAlertController(title: "照片访问受限",
                                                    message: "点击“设置”，允许访问您的照片",
                                                    preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title:"取消", style: .cancel, handler:nil)
            
            let settingsAction = UIAlertAction(title:"设置", style: .default, handler: {
                (action) -> Void in
                let url = URL(string: UIApplicationOpenSettingsURLString)
                if let url = url, UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url, options: [:],
                                                  completionHandler: {
                                                    (success) in
                        })
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            
            self.present(alertController, animated: true, completion: nil)
        })
        }
        return false
    }
//#pragma mark ************CAReplicatorLayer**********************
    func setReplicatorLayer() {
        let replicator = CAReplicatorLayer()
        replicator.frame = self._vCenter.bounds
        
        replicator.instanceCount = 30
        replicator.instanceDelay = CFTimeInterval(1 / 30.0)
        replicator.preservesDepth = false
        replicator.instanceColor = UIColor.white.cgColor
        
        replicator.instanceRedOffset = 0.0
        replicator.instanceGreenOffset = -0.5
        replicator.instanceBlueOffset = -0.5
        replicator.instanceAlphaOffset = 0.0
        
        let angle = Float(Double.pi*2.0)/30
        replicator.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0, 0, 1.0)
        self._vCenter.layer.addSublayer(replicator)
        
        let layer = CALayer()
        let layerW: CGFloat = 10.0
        let midX = self._vCenter.bounds.minX - layerW/2.0
        layer.frame = CGRect(x:midX,y:0,width:layerW,height:layerW * 3.0)
        layer.backgroundColor = UIColor.white.cgColor
        replicator.addSublayer(layer)
        
        let fadeAni = CABasicAnimation(keyPath:"opacity")
        fadeAni.fromValue = 1.0
        fadeAni.toValue = 0.0
        fadeAni.duration = 1
        fadeAni.repeatCount = Float.greatestFiniteMagnitude
        
        layer.opacity = 0.0
        layer.add(fadeAni, forKey: "FadeAnimation")
    }

}
extension String{
    func OCRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),length: utf16.distance(from: from, to: to))
        
        
    }
    func swiftRange(from OCRange: NSRange) -> Range<String.Index>? {
        guard
            
            let from16 = utf16.index(utf16.startIndex, offsetBy: OCRange.location,
                                     limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: OCRange.length,
                                limitedBy: utf16.endIndex),
        let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)

            else {return nil}
            return from ..< to
    }
}

extension UIImage {
    
    //生成群聊图标
    class func groupIcon(wh:CGFloat, images:[UIImage], bgColor:UIColor?) -> UIImage {
        let finalSize = CGSize(width:wh, height:wh)
        var rect: CGRect = CGRect.zero
        rect.size = finalSize
        
        //开始图片处理上下文（由于输出的图不会进行缩放，所以缩放因子等于屏幕的scale即可
        UIGraphicsBeginImageContextWithOptions(finalSize, false, 0)
        
        //绘制背景
        if (bgColor != nil) {
            let context: CGContext = UIGraphicsGetCurrentContext()!
            //添加矩形背景区域
            context.addRect(rect)
            //设置填充颜色
            context.setFillColor(bgColor!.cgColor)
            context.drawPath(using: .fill)
        }
        
        //绘制图片
        if images.count >= 1 {
            //获取群聊图标中每个小图片的位置尺寸
            var rects = self.getRectsInGroupIcon(wh:wh, count:images.count)
            var count = 0
            //将每张图片绘制到对应的区域上
            for image in images {
                if count > rects.count-1 {
                    break
                }
                
                let rect = rects[count]
                image.draw(in: rect)
                count = count + 1
            }
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext() 
        return newImage!
    }
    
    //获取群聊图标中每个小图片的位置尺寸
    class func getRectsInGroupIcon(wh:CGFloat, count:Int) -> [CGRect] {
        //如果只有1张图片就直接占全部位置
        if count == 1 {
            return [CGRect(x:0, y:0, width:wh, height:wh)]
        }
        
        //下面是图片数量大于1张的情况
        var array = [CGRect]()
        //图片间距
        var padding: CGFloat = 10
        //小图片尺寸
        var cellWH: CGFloat
        //用于后面计算的单元格数量（小于等于4张图片算4格单元格，大于4张算9格单元格）
        var cellCount:Int
        
        if count <= 4 {
            cellWH = (wh-padding*3)/2
            cellCount = 4
        } else {
            padding = padding/2
            cellWH = (wh-padding*4)/3
            cellCount = 9
        }
        
        //总行数
        let rowCount = Int(sqrt(Double(cellCount)))
        //根据单元格长宽，间距，数量返回所有单元格初步对应的位置尺寸
        for i in 0..<cellCount {
            //当前行
            let row = i/rowCount
            //当前列
            let column = i%rowCount
            let rect = CGRect(x:padding*CGFloat(column+1)+cellWH*CGFloat(column),
                              y:padding*CGFloat(row+1)+cellWH*CGFloat(row),
                              width:cellWH, height:cellWH)
            array.append(rect)
        }
        
        //根据实际图片的数量再调整单元格的数量和位置
        if count == 2 {
            array.removeSubrange(0...1)
            for i in 0..<array.count {
                array[i].origin.y = array[i].origin.y - (padding+cellWH)/2
            }
        }else if count == 3 {
            array.remove(at: 0)
            array[0].origin.x = (wh-cellWH)/2
        }else if count == 5 {
            array.removeSubrange(0...3)
            for i in 0..<array.count {
                if i<2 {
                    array[i].origin.x = array[i].origin.x - (padding+cellWH)/2
                }
                array[i].origin.y = array[i].origin.y - (padding+cellWH)/2
            }
        }else if count == 6 {
            array.removeSubrange(0...2)
            for i in 0..<array.count {
                array[i].origin.y = array[i].origin.y - (padding+cellWH)/2
            }
        }else if count == 7 {
            array.removeSubrange(0...1)
            array[0].origin.x = (wh-cellWH)/2
        }
        else if count == 8 {
            array.remove(at: 0)
            for i in 0..<2 {
                array[i].origin.x = array[i].origin.x - (padding+cellWH)/2
            }
        }
        return array
    }
}



















