# HHJUploadImages
A swift upload image tool.
HHJUploadImages是一个用来上传图片的swift工具类
#如何在项目中导入
* HHJUploadImages只有一个文件，就是HHJUploadImages.swift，你可以把它直接拖进过程里面。
```
platform :ios, '8.0'
use_frameworks!

pod 'HHJUploadImages', '~> 1.0.0'
```
# 如何在项目中使用
HHJUploadImages有一个公开的类方法：
func uploadimages(images:[UIImage], stringUrl: String, params: [String: String], blocK: HHJUploadImagesBlock?)