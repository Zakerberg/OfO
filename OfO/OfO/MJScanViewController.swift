//
//  MJScanViewController.swift
//  OfO
//  扫码界面
//  Created by Michael 柏 on 2017/6/25.
//  Copyright © 2017年 Michael 柏. All rights reserved.
//

import UIKit

class MJScanViewController: LBXScanViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "扫码用车"
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.tintColor = UIColor.white
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
