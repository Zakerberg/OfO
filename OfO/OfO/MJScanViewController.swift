//
//  MJScanViewController.swift
//  OfO
//  扫码界面
//  Created by Michael 柏 on 2017/6/25.
//  Copyright © 2017年 Michael 柏. All rights reserved.
//

import UIKit
import FTIndicator

class MJScanViewController: LBXScanViewController {

    
    @IBOutlet weak var flashBtn: UIButton!
    
    @IBOutlet weak var pannelView: UIView!
  
    var isFlashOn = false
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.bringSubview(toFront: pannelView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "扫码用车"
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.tintColor = UIColor.white
    
        var style = LBXScanViewStyle()
        style.anmiationStyle = .NetGrid
        
        // 引用Bundle文件中的图片
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_part_net")
        
        scanStyle = style
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        
        if let result = arrayResult.first {
            
            let msg = result.strScanned
            
            FTIndicator.setIndicatorStyle(.dark)
            FTIndicator.showToastMessage(msg)
        }
    }
    
    
    
    
//MARK: -- flashBtnClick
    
    @IBAction func flashBtnTap(_ sender: UIButton) {
        isFlashOn = !isFlashOn
        scanObj?.changeTorch()
        
        if isFlashOn {
            flashBtn.setImage(#imageLiteral(resourceName: "lightopen"), for: .normal)
        } else {
            flashBtn.setImage(#imageLiteral(resourceName: "torch_close_icon"), for: .normal)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
