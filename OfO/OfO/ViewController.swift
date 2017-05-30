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
    var pin :MyPinAnnotation!
    
    /*  屏幕中心大头针  */
    var pinView :MAPinAnnotationView!
    
    /* 首页面板   */
    @IBOutlet weak var panelView: UIView!
    /* 首页定位按钮 */
    @IBAction func LocationBtnClick(_ sender: UIButton) {
        searchBikeNearBy()
    }
    
    //搜索周边的小黄车
    func searchBikeNearBy() {
        searchCustomerLocation(mapView.userLocation.coordinate)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MAMapView(frame: view.bounds)
        view.addSubview(mapView)
        view.bringSubview(toFront: panelView)
        
        mapView.delegate = self
        mapView.zoomLevel = 17
        
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
    
//MARK: ------------ MapView Delegate(地图初始化完成) ------------
    func mapInitComplete(_ mapView: MAMapView!) {
        pin = MyPinAnnotation()
        pin.coordinate = mapView.centerCoordinate
        pin.lockedScreenPoint = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        pin.isLockedToScreen = true
        
        mapView.addAnnotation(pin)
        mapView.showAnnotations([pin], animated: true)
    }
    
    
//MARK: ------------ MapView Delegate(自定义大头针) ------------
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        /*** 用户定位的位置,不需要自定义   ***/
        if annotation is MAUserLocation {
            return nil
        }
        
        if  annotation is MyPinAnnotation {
            let reuseid = "Mypinid"
            var annotaionV = mapView.dequeueReusableAnnotationView(withIdentifier: reuseid)
            if annotaionV == nil {
                annotaionV = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reuseid)
            }
            
            annotaionV?.image = #imageLiteral(resourceName: "homePage_wholeAnchor")
            annotaionV?.canShowCallout = false
            
            pinView = annotaionV as! MAPinAnnotationView
            return annotaionV
            
        }
        
        let reuseid = "reuseid"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseid) as? MAPinAnnotationView
        
        if annotationView == nil {
            annotationView = MAPinAnnotationView(annotation: annotation, reuseIdentifier: reuseid)
        }
        
        if annotation.title == "正常可用" {
            annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBike")
        } else {
            annotationView?.image = #imageLiteral(resourceName: "HomePage_nearbyBikeRedPacket")
        }
        
        annotationView?.canShowCallout = true
        annotationView?.animatesDrop = true
        
        return annotationView
    }
    
//MARK: ------------ Map Search Delegate(搜索) ------------------
    /***  搜索周边完成后的处理  ***/
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        guard response.count > 0 else {
            print("周边没有小黄车")
            return
        }
        
        var annotations : [MAPointAnnotation] = []
        
        annotations = response.pois.map {
            
            let annotation = MAPointAnnotation()
            
            annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees($0.location.latitude), longitude: CLLocationDegrees($0.location.longitude))
            
            if $0.distance < 400 {
                annotation.title = "红包车"
                annotation.subtitle = "开锁骑行10分钟得现金红包"
            } else {
                annotation.title = "正常可用"
            }
            return annotation
        }
        
        mapView.addAnnotations(annotations)
        mapView.showAnnotations(annotations, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

