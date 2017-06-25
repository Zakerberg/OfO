//
//  MJScanViewController.swift
//  OfO
//  扫码界面
//  Created by Michael 柏 on 2017/6/25.
//  Copyright © 2017年 Michael 柏. All rights reserved.
//

import UIKit

class MJScanViewController: LBXScanViewController {

    
    @IBOutlet weak var flashBtn: UIButton!
    
    @IBOutlet weak var pannelView: UIView!
  
    var isFlashOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "扫码用车"
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.tintColor = UIColor.white
    
        
        var style = LBXScanViewStyle()
        style.anmiationStyle = .NetGrid
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_part_net")
        
        scanStyle = style
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    //闪光灯
    @IBAction func flashBtnTap(_ sender: UIButton) {
        isFlashOn = !isFlashOn
        scanObj?.changeTorch()
        
        if isFlashOn {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch"), for: .normal)
        } else {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_torch_disable"), for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.bringSubview(toFront: pannelView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
