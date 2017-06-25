//
//  ViewController.swift
//  OfO
//  主页面
//  Created by Michael 柏 on 2017/5/29.
//  Copyright © 2017年 Michael 柏. All rights reserved.
//

import UIKit
import SWRevealViewController
import FTIndicator

class ViewController: UIViewController,MAMapViewDelegate,AMapSearchDelegate,AMapNaviWalkManagerDelegate{
    
    var mapView : MAMapView!
    /* SearchAPI */
    var search: AMapSearchAPI!
    var pin : MyPinAnnotation!
    var nearBySearch = true
    var start,end : CLLocationCoordinate2D!
    var walkManager : AMapNaviWalkManager!
    
    
    /*  屏幕中心大头针  */
    var pinView :MAPinAnnotationView!
    
    /* 首页面板 */
    @IBOutlet weak var panelView: UIView!
    /* 首页定位按钮 */
    @IBAction func LocationBtnClick(_ sender: UIButton) {
        nearBySearch = true
        searchBikeNearBy()
    }
    
    /* 搜索周边的小黄车 */
    func searchBikeNearBy() {
        searchCustomerLocation(mapView.userLocation.coordinate)
    }
    
    func searchCustomerLocation(_ center:CLLocationCoordinate2D)  {
        
        /* 周边检索 */
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
        
        walkManager = AMapNaviWalkManager()
        walkManager.delegate = self
        
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
    
    
    //MARK: -- (大头针动画)
    func pinAnimation() {
        //坠落动画 ,Y加位移
        let endFrame = pinView.frame
        pinView.frame = endFrame.offsetBy(dx: 0, dy: -15)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
            self.pinView.frame = endFrame
        }, completion: nil)
    }
    
    
    //MARK: -- MapView Delegate
    
    func mapView(_ mapView: MAMapView!, didAddAnnotationViews views: [Any]!)
    {
        let aViews = views as! [MAAnnotationView]
        
        for aView in aViews {
            guard aView.annotation is MAPointAnnotation else {
                continue
            }
            aView.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
                aView.transform = .identity
            }, completion: nil)
        }
    }
    
    
    /* (绘制路线) */
    func mapView(_ mapView: MAMapView!, rendererFor overlay: MAOverlay!) -> MAOverlayRenderer! {
        
        if overlay is MAPolyline {
            pin.isLockedToScreen = false
            
            mapView.visibleMapRect = overlay.boundingMapRect
            
            let renderer = MAPolylineRenderer(overlay: overlay)
            renderer?.strokeColor = UIColor.blue
            renderer?.lineWidth = 8.0
            
            return renderer
        }
        return nil
    }
    
    /*(导航规划)*/
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        
        start = pin.coordinate
        end = view.annotation.coordinate
        let startPoint = AMapNaviPoint.location(withLatitude: CGFloat(start.latitude), longitude: CGFloat(end.longitude))!
        let endPoint = AMapNaviPoint.location(withLatitude: CGFloat(end.latitude), longitude: CGFloat(end.longitude))!
        
        walkManager.calculateWalkRoute(withStart: [startPoint], end: [endPoint])
    }
    
    
    /* (地图初始化完成) */
    func mapInitComplete(_ mapView: MAMapView!) {
        pin = MyPinAnnotation()
        pin.coordinate = mapView.centerCoordinate
        pin.lockedScreenPoint = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
        pin.isLockedToScreen = true
        
        mapView.addAnnotation(pin)
        mapView.showAnnotations([pin], animated: true)
        
        searchBikeNearBy()
    }
    
    /* (地图用户的交互) */
    func mapView(_ mapView: MAMapView!, mapDidMoveByUser wasUserAction: Bool)
    {
        if wasUserAction {
            pin.isLockedToScreen = true
            pinAnimation()
            searchCustomerLocation(mapView.centerCoordinate)
        }
    }
    
    /* (自定义大头针) */
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        /*** 用户定位的位置,不需要自定义 ***/
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
    
    //MARK: -- Map Search Delegate(搜索)
    
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
        
        if nearBySearch {
            mapView.showAnnotations(annotations, animated: true)
            nearBySearch = !nearBySearch
        }
    }
    
    //MARK: -- AMapNaviWalkManagerDelegate
    
    func walkManager(onCalculateRouteSuccess walkManager: AMapNaviWalkManager) {
        print("规划路径成功")
    
        mapView.removeOverlays(mapView.overlays)
        
        var coordinates = walkManager.naviRoute!.routeCoordinates!.map {
            
            return CLLocationCoordinate2D(latitude: CLLocationDegrees($0.latitude), longitude: CLLocationDegrees($0.longitude))
        }
        
        let polyline = MAPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
        
        mapView.add(polyline)
        
        //用时
        let walkMintues = walkManager.naviRoute!.routeTime / 60;
        
        var timeDesc = "一分钟以内"
        if walkMintues > 0 {
            timeDesc = walkMintues.description + "分钟"
        }
        
        let hintTitle = "步行" + timeDesc
        let SubTitle = "距离" + walkManager.naviRoute!.routeLength.description + "米"
        
        FTIndicator.setIndicatorStyle(.dark)
        FTIndicator.showNotification(with: #imageLiteral(resourceName: "clock"), title: hintTitle, message: SubTitle)
        
        
    }
    
    func walkManager(_ walkManager: AMapNaviWalkManager, onCalculateRouteFailure error: Error) {
        print("规划路径失败:",error)
    }
    
}

