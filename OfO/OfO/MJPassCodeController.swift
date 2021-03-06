//
//  MJPassCodeController.swift
//  OfO
//
//  Created by Michael 柏 on 2017/8/20.
//  Copyright © 2017年 Michael 柏. All rights reserved.
//  ----------------- 车辆解锁码控制器 -----------------

import UIKit
import SwiftyTimer
import SwiftySound

class MJPassCodeController: UIViewController {
    var Code = 0 //解锁码
    var remindSeconds = 120
    var isTorchOn = false
    var isVoiceOn = true
    
    @IBOutlet weak var torchBtn: UIButton!
    @IBOutlet weak var voiceBtn: UIButton!
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
        
        voiceBtnStatus(voiceBtn: voiceBtn)
    }
    
    /// 报修按钮
    @IBAction func reportBtnClick(_ sender: UIButton) {
        
        dismiss(animated: true) {
        
        }
    }
    
    /// 声音
    @IBAction func voiceBtnClick(_ sender: UIButton) {
        
        isVoiceOn = !isVoiceOn
    }
    
    /// 后置闪光灯
    @IBAction func torchBtnClick(_ sender: UIButton) {
        turnTorch()
        
        if isTorchOn {
            torchBtn.setImage(#imageLiteral(resourceName: "btn_unenableTorch"), for: .normal)
        }else{
            torchBtn.setImage(#imageLiteral(resourceName: "btn_torch_disable"), for: .normal)
        }
        
        isTorchOn = !isTorchOn
    }
}
