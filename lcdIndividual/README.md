# lcdIndividual
1.UIBezierPath是对CGPathRef数据类型的封装.创建和使用path对象步骤：
    1.重写View的drawRect方法
    2.创建UIBezierPath的对象
    3.使用方法MoveToPath:设置起始点
    4.根据具体要求使用UIBezierPath类方法绘制图形(比如线，矩形，圆，弧形，)
    5.设置UIBezierPath对象的相关属性(比如lineWith,lineJoinStyle,color)
    6.使用stroke或者fill方法结束绘图
    
2.Week底层实现
    Weak 弱引用，所引用的计数器不会加1，并在引用对象被释放时，自动设置为nil，通常用于解决循环引用的问题。
    weak表 是一个hash表，Key所指向对象的地址，Value是weak指针的地址数组。
    1.初始化：runtime会调用objc_initWeak函数，初始化一个新的weak指针指向对象的地址。
    2.添加引用：objc_initWeak函数会调用objc_strokeWeak()函数，objc_storeWeak()的作用是更新指针指向，创建对应的弱引用表。
    3.释放：调用clearDeallocating函数。clearDeallocating函数首先根据对象地址获取所有weak指针地址的数组，然后遍历这个数组其中的数据设置为nil，最后把这个entry从weak表中删除，然后清理对象的记录。
    
3.@property = ivar(实例变量 ) + getter + setter
    属性关键字 1.原子性       默认:atomic, nonatomic
    2.存取特性  默认：readwrite
    3.内存管理特性：strong:表明你需要引用(持有)这个对象(reference to the object)，负责保持这个对象的生命周期
                                weak:ARC特性，会给你一个引用，指向对象。但是不会主张所有权，也不会增加引用计数[retain count],如果对象A被销毁，所有指向对象A的引用(weak reference)(用weak修饰的属性)，都会自动设置为nil。 在delegate patterns中常用weak解决循环引用
                                copy: 所有mutable(可变)版本的属性类型，如NSString, NSArray, NSDictionary等----他们都有可变版本类型：NSMutableString,NSMutableArray, NSMutableDictionary。这些类型在属性赋值时，右边的值有可能是他们呢的可变版本。这样就会出现属性值被意外改变的可能。所以他们呢都应该引用copy。
                                assign:作用和weak类似，如果对象A被销毁，所有指向这个对象A的assign属性并不会自动设置为nil。这个时候这些属性就变成野指针，再访问这些属性，程序就会crash。在ARC下，assign就被变成用于修饰基本数据类型，也就是非对象/非指针数据类型，如int,Bool,float等。

4.NSAssert()是一个宏，用于开发阶段调试程序中的bug，通过NSAssert()传递条件表达式来断定是否属于Bug,满足条件返回真值，程序继续运行，如果返回假值，则抛出异常，并且可以自定义异常描述。  #define NSAssert(condition, desc)  //condition为Bool类型，desc为NSString类型.
NSAssertionHandler实例是自动创建的，用于处理错误断言，如果 NSAssert和NSCAssert条件评估为错误，会向 NSAssertionHandler实例发送一个表示错误的字符串。每个线程都有它自己的NSAssertionHandler实例。我们可以自定义处理方法，从而使用断言的时候，控制台输出错误，但是程序不会直接崩溃。

5.AFN 源码分析
        1. AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
            AFHTTPRequestOperationManager所有网络请求都由manager发起
        2.默认提交请求数据的格式是二进制，返回格式是JSON
            如果是JSON，需要设置请求格式为AFJSONRequestSerializer
        3.请求格式
            AFHTTPRequestSerializer     二进制
            AFJSONRequestSerializer    JSON
            AFPropertyListRequestSerializer  PList(特殊的XML，解析相对简单)
        4.返回格式
            AFHTTPResponseSerializer 二进制格式
            AFJSONResponseSerializer JSON AFXMLParserResponseSerializer XML,只能返回XMLParser,还需要自己通过代理方法解析
            
            AFXMLDocumentResponseSerializer (Mac OS X)
            AFPropertyListResponseSerializer PList
            AFImageResponseSerializer Image
            AFCompoundResponseSerializer 组合
            
            













































