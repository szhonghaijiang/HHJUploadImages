# HHJUploadImages
A swift upload image tool.
HHJUploadImages是一个用来上传图片的swift工具类
#如何在项目中导入
* HHJUploadImages只有一个文件，就是HHJUploadImages.swift，你可以把它直接拖进过程里面。
* 当然我是建议用cocospod导入的，用cocospod导入的最低版本是iOS8：
```
platform :ios, '8.0'
use_frameworks!

pod 'HHJUploadImages', '~> 1.0.0'
```
# 如何在项目中使用
##HHJUploadImages有一个公开的类方法：
func uploadimages(images:[UIImage], stringUrl: String, params: [String: String], blocK: HHJUploadImagesBlock?)

##使用以下类属性来修改个性化需求
* repeatWhileUploadFail:上传某张图片图片失败后重复的次数，默认是0次，即不重复，此参数设置一次后，对以后所有上传动作生效
* stopWhileUploadFail:上传图片失败后是否还停止上传还未上传的图片，默认是false，此参数设置一次后，对以后所有上传动作生效
