AFNetworking-demo
=================

##AFNetworking2.5.3的一个完整实现demo  

![](https://raw.githubusercontent.com/shaojiankui/AFNetworking-demo/master/demo.gif)

###1.Controller    项目中的各种viewcontroller  

###2.Common  共通类,各种基类  
######APIClient             网络请求单例
######BaseModel             实体的父类 继承JSONModel 可以直接把字典映射成对象 
######BaseViewController    本项目所有ViewController的父类 
######Util                  项目工具类 用于写一些常用的类方法 
  
###3.Model   实体
  
###4.Vendor 各种第三方组件  
######AFNetworking          网络请求框架
######UIKit+AFNetworking    AFNetworking 扩展 
######JSONModel             字典映射成对象组件
######SSKeychain            第三方钥匙串框架 

###5.Category 各种 Category

###6.Constant.h 项目中用到的各种宏定义 已经包含到了**Prefix.pch文件中
###7.server.php  服务器端与afnetworking交互的demo
