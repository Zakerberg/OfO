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
   
    @IBOutlet weak var flashBtn: UIButton!
    
    @IBOutlet weak var voiceBtn: UIButton!
    
    var isFlashOn = false
    var isVoiceOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inputTF.layer.borderColor = UIColor.OfO.cgColor
        inputTF.layer.borderWidth = 2
        
    }

    //MARK: -- BtnClick
    
    @IBAction func flashBtnClick(_ sender: UIButton) {
        
        isFlashOn = !isFlashOn
        isFlashOn ? flashBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch"), for: .normal) : flashBtn.setImage(#imageLiteral(resourceName: "btn_unenableTorch"), for: .normal)
    }
    
    @IBAction func voiceBtnClick(_ sender: UIButton) {
        
        isVoiceOn = !isVoiceOn
        isVoiceOn ? voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal) : voiceBtn.setImage(#imageLiteral(resourceName: "voiceclose"), for: .normal)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
