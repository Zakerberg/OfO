//
//  MJHomeWebViewController.swift
//  OfO
//
//  Created by Michael 柏 on 2017/5/29.
//  Copyright © 2017年 Michael 柏. All rights reserved.
//

import UIKit
import WebKit

class MJHomeWebViewController: UIViewController {

    var webView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: self.view.frame)
        view.addSubview(webView)
        self.title = "活动中心"
        let url = URL(string: "http://m.ofo.so/active.html")!
        let request = URLRequest(url:url )
        
        webView.load(request)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
