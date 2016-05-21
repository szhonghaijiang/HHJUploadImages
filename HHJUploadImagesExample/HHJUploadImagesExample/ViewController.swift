//
//  ViewController.swift
//  HHJUploadImagesExample
//
//  Created by bu88 on 16/5/20.
//  Copyright © 2016年 HM. All rights reserved.
//

import UIKit

let sid = "sid"

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HHJUploadImage.repeatUploadWhileFaile = 2
        HHJUploadImage.stopWhileUploadFail = true
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let iamge1 = UIImage(named: "pet_add")
        let image2 = UIImage(named: "switchOff")
        let image3 = UIImage(named: "switchOn")
        
        HHJUploadImage.uploadimages([iamge1!, image2!, image3!], stringUrl: "", params: ["sid": sid]) { (data, response, error, index) in
            print("data?.length:\(data?.length)")
            print("response:\(response)")
            print("error:\(error)")
            print("index:\(index)")
        }
    }
}

