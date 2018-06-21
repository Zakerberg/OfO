//
//  MJInputViewController.swift
//  OfO
//
//  Created by Michael 柏 on 2017/7/29.
//  Copyright © 2017年 Michael 柏. All rights reserved.
//  ----------------- 输入车牌控制器 -------------------

import UIKit
import APNumberPad

class MJInputViewController: UIViewController,APNumberPadDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var inputTF: UITextField!
    @IBOutlet weak var flashBtn: UIButton!
    @IBOutlet weak var voiceBtn: UIButton!
    @IBOutlet weak var goBtn: UIButton!
    
    var isFlashOn = false
    var isVoiceOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputTF.layer.borderColor = UIColor.OfO.cgColor
        inputTF.layer.borderWidth = 2
        title = "车辆解锁"
        
        let numerPad = APNumberPad(delegate: self)
        numerPad.leftFunctionButton.setTitle("确定", for: .normal)
        inputTF.inputView = numerPad
        inputTF.delegate = self
        goBtn.isEnabled = false
        
        voiceBtnStatus(voiceBtn: voiceBtn)
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
    
    @IBAction func goBtnClick(_ sender: UIButton) {

    }
    
    //MARK: -- APNumberPadDelegate
    
    func numberPad(_ numberPad: APNumberPad, functionButtonAction functionButton: UIButton, textInput: UIResponder) {
        
        print("点击了确定!")
        
        if !inputTF.text!.isEmpty {
            
            performSegue(withIdentifier: "showCode", sender: self)
        }
    }
    
    //MARK: -- UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = inputTF.text else {
            return true
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
        
        if newLength > 0 {
            goBtn.setImage(#imageLiteral(resourceName: "nextArrow_enable"), for: .normal)
            goBtn.backgroundColor = UIColor.OfO
            goBtn.isEnabled = true
        } else {
            goBtn.setImage(#imageLiteral(resourceName: "nextArrow_unenable"), for: .normal)
            goBtn.backgroundColor = UIColor.groupTableViewBackground
            goBtn.isEnabled = false
        }
        
        return newLength <= 8
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
