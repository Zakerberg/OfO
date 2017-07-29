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
}







