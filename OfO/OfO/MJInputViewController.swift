//
//  MJInputViewController.swift
//  OfO
//
//  Created by Michael 柏 on 2017/7/29.
//  Copyright © 2017年 Michael 柏. All rights reserved.
//  ----------------- 输入车牌控制器 -------------------

import UIKit

class MJInputViewController: UIViewController {

    @IBOutlet weak var inputTF: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()


        inputTF.layer.borderColor = UIColor.OfO.cgColor
        inputTF.layer.borderWidth = 2
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
