//
//  ExtensionHelper.swift
//  OfO
//
//  Created by Michael 柏 on 2017/7/29.
//  Copyright © 2017年 Michael 柏. All rights reserved.
//


extension UIColor {
    
    static var OfO: UIColor {
        
        return UIColor(red: 247/255, green: 215/255, blue: 80/255, alpha: 1)
    }
}


extension UIView {
    
  @IBInspectable var borderWidth: CGFloat {
        
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
   @IBInspectable var borderColor: UIColor {
        
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
  @IBInspectable var cornerRadius: CGFloat {
    
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
}

@IBDesignable class myPreviewLabel : UILabel {
    
}

/// 后置闪光灯

import AVFoundation

func turnTorch() {
    
    guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio) else {
        return
    }
    
    if device.hasTorch && device.isTorchAvailable {
        try? device.lockForConfiguration()
        
        if device.torchMode == .off{
            device.torchMode = .on
        }else{
            device.torchMode = .off
        }
        
        device.unlockForConfiguration()
    }
}

func voiceBtnStatus(voiceBtn: UIButton)  {
    let defalults = UserDefaults.standard
    
    if defalults.bool(forKey: "isVoiceOn") {
        
        voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)
    }else{
        voiceBtn.setImage(#imageLiteral(resourceName: "voiceclose"), for: .normal)
    }
}













