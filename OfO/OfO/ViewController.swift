//
//  ViewController.swift
//  OfO
//
//  Created by Michael 柏 on 2017/5/29.
//  Copyright © 2017年 Michael 柏. All rights reserved.
//

import UIKit
import SWRevealViewController

class ViewController: UIViewController,MAMapViewDelegate,AMapSearchDelegate {
    
    var mapView :MAMapView!
    /* SearchAPI  */
    var search:AMapSearchAPI!
    
    
    /* 首页面板   */
    @IBOutlet weak var panelView: UIView!
    /* 首页定位按钮 */
    @IBAction func LocationBtnClick(_ sender: UIButton) {
    }
    
    //搜索周边的小黄车
    func searchBikeNearBy() {
        
    }
    
    func searchCustomerLocation(_ center:CLLocationCoordinate2D)  {
        
        /*  周边检索  */
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(center.latitude), longitude: CGFloat(center.longitude))
        request.keywords = "餐馆"
        request.radius = 500
        request.requireExtension = true
        
        search.aMapPOIAroundSearch(request)
    }
    
    /***  搜索周边完成后的处理  ***/
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        
        guard response.count > 0 else {
            print("周边没有小黄车")
            return
        }
        
        for poi in response.pois {
            print(poi.name)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MAMapView(frame: view.bounds)
        view.addSubview(mapView)
        view.bringSubview(toFront: panelView)
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        search = AMapSearchAPI()
        search.delegate = self
        
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "ofoLogo"))
        self.navigationItem.leftBarButtonItem?.image = #imageLiteral(resourceName: "leftTopImage").withRenderingMode(.alwaysOriginal)
         self.navigationItem.rightBarButtonItem?.image = #imageLiteral(resourceName: "rightTopImage") .withRenderingMode(.alwaysOriginal)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if let revealVC = revealViewController() {
            revealVC.rearViewRevealWidth = 280
            
            navigationItem.leftBarButtonItem?.target = revealVC
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer()) 
        }
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

