//
//  Common.swift
//  OfO
//
//  Created by Michael 柏 on 2017/5/30.
//  Copyright © 2017年 Michael 柏. All rights reserved.
//

import UIKit

//高德地图需要的东西
let MapAppKey = "ffba64661a9c0db240d6c5ea8f477470"


// 屏幕的宽度和高度
let MJSCREENW = UIScreen.main.bounds.width
let MJSCREENH = UIScreen.main.bounds.height

// RGB颜色
func RGB(r:Float, g: Float, b: Float, alpha: Float = 1) -> UIColor {
    return UIColor(colorLiteralRed: r/Float(255), green: g/Float(255), blue: b/Float(255), alpha: alpha)
}
// 随机颜色
func MJRandomColor() -> UIColor{
    let r =  Float(arc4random()%256)
    let g =  Float(arc4random()%256)
    let b =  Float(arc4random()%256)
    return RGB(r: r, g: g, b: b)
}
