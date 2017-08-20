//
//  MJPassCodeController.swift
//  OfO
//
//  Created by Michael 柏 on 2017/8/20.
//  Copyright © 2017年 Michael 柏. All rights reserved.
//  ----------------- 车辆解锁码控制器 -----------------

import UIKit
import SwiftyTimer

class MJPassCodeController: UIViewController {
    
    var remindSeconds = 120
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.every(1) { (timer: Timer) in
            
            self.countDownLabel.text = self.remindSeconds.description
            self.remindSeconds -= 1
            if self.remindSeconds == 0{
                timer.invalidate()
            }
        }
    }
    
    @IBAction func reportBtnClick(_ sender: UIButton) {
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
