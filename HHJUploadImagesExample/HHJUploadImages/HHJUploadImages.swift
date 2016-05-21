//
//  HHJUplodaImages.swift
//  HHJUplodaImagesExample
//
//  Created by szulm on 16/5/20.
//  Copyright © 2016年 HM. All rights reserved.
//

import Foundation
import UIKit

public typealias HHJUploadImagesBlock = (data: NSData?, response: NSURLResponse?, error: NSError?, index: Int) -> Void
public class HHJUploadImage: NSObject, NSURLSessionDelegate {
    
    /**
     //公开一个类方法用来上传图片
     
     - parameter images:    图片数组
     - parameter stringUrl: 地址
     - parameter params:    参数
     */
    public static func uploadimages(images:[UIImage], stringUrl: String, params: [String: String], blocK: HHJUploadImagesBlock?) {
        HHJUploadImage.hhjUploadImageInstance.uploadimages(images, stringUrl: stringUrl, params: params, blocK: blocK)
    }
    
    /// 上传某张图片图片失败后重复的次数，默认是0次，即不重复，此参数设置一次后，对以后所有上传动作生效
    public static var repeatUploadWhileFaile = 0
    /// 上传图片失败后是否还停止上传还未上传的图片，默认是false，此参数设置一次后，对以后所有上传动作生效
    public static var stopWhileUploadFail = false
    
    static let hhjUploadImageInstance = HHJUploadImage()
    /**
     上传多张图片
     
     - parameter images:    图片数组
     - parameter stringUrl: 地址
     - parameter params:    参数
     - parameter blocK:     回调Block
     */
    var currentImageIndex = 0
    var currentImageRepeatCount = 0
    var images: [UIImage]!
    var block: HHJUploadImagesBlock?
    func uploadimages(images:[UIImage], stringUrl: String, params: [String: String], blocK:HHJUploadImagesBlock?)  {
        assert(images.count > 0, "上传的图片数组不能为空！")
        currentImageIndex = 0
        currentImageRepeatCount = 0
        let image = images[currentImageIndex]
        self.images = images
        self.block = blocK
        uploadimage(image, stringUrl: stringUrl, params: params)
    }
    
    
    // MARK-:上传单张图片
    func uploadimage(image:UIImage, stringUrl: String, params: [String: String]) {
        guard let url = NSURL(string: stringUrl) else {
            assertionFailure("\(stringUrl) 无法生成URL")
            return
        }
        
        let request = NSMutableURLRequest(URL: url, cachePolicy: .ReloadIgnoringCacheData, timeoutInterval: 60)
        request.HTTPMethod = "POST"
        request.HTTPShouldHandleCookies = true
        for (key, value) in params {
            request.setValue(value, forHTTPHeaderField: key)
        }
        let boundary = "unique-consistent-string"
        let contentType = String(format: "multipart/form-data; boundary=%@", boundary)
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        let data = NSMutableData()
        data.appendData(String(format: "--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        data.appendData(String(format: "Content-Disposition: form-data; name=%@\r\n\r\n", "imageCaption").dataUsingEncoding(NSUTF8StringEncoding)!)
        data.appendData(String(format: "%@\r\n", "Some Caption").dataUsingEncoding(NSUTF8StringEncoding)!)
        
        var imageData = UIImageJPEGRepresentation(image, 1)
        if imageData == nil {
            imageData = UIImagePNGRepresentation(image)
        }
        
        if imageData != nil {
            data.appendData(String(format: "--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
            data.appendData(String(format: "Content-Disposition: form-data; name=%@; filename=imageNamestory.jpg\r\n", "imageFormKey").dataUsingEncoding(NSUTF8StringEncoding)!)
            data.appendData(String(format: "Content-Type: image/jpeg\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
            data.appendData(imageData!)
            data.appendData(String(format: "\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        data.appendData(String(format: "--%@--\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        request.HTTPBody = data
        request.setValue(String(format: "%d", data.length), forHTTPHeaderField: "Content-Length")
        
        let session = NSURLSession.sharedSession()
        
        var dataTask: NSURLSessionUploadTask! = nil
        dataTask = session.uploadTaskWithRequest(request, fromData: nil) { (data, response, error) -> Void in
            //回调
            if let tempBlock = self.block {
                tempBlock(data: data, response: response, error: error, index: self.currentImageIndex)
            }
            //处理错误的逻辑
            if error != nil {
                //小于最大的上传次数
                if self.currentImageRepeatCount < HHJUploadImage.repeatUploadWhileFaile {
                    self.currentImageRepeatCount += 1
                    self.uploadimage(image, stringUrl: stringUrl, params: params)
                    return
                }
            }
            
            self.currentImageRepeatCount = 0
            self.currentImageIndex += 1
            if self.currentImageIndex >= self.images.count || (error != nil && HHJUploadImage.stopWhileUploadFail)  { return }
            let image = self.images[self.currentImageIndex]
            self.uploadimage(image, stringUrl: stringUrl, params: params)
        }
        dataTask.resume()
    }
}

