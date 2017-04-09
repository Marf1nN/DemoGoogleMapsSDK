//
//  ViewController.swift
//  DemoGoogleMapsSDK
//
//  Created by Vladyslav Filippov on 01.04.17.
//  Copyright © 2017 Vladyslav Filippov. All rights reserved.
//

import UIKit
import GoogleMaps

class VacationDestination : NSObject {
    
    let name : String?
    let location : CLLocationCoordinate2D
    let zoom : Float
    
    init(name: String , location : CLLocationCoordinate2D, zoom : Float) {
        self.name = name
        self.location = location
        self.zoom = zoom
        
    }
    //50.359964, 30.430502
}

class ViewController: UIViewController , GMSMapViewDelegate {

    var mapView : GMSMapView?
    
    var currentDestination : VacationDestination?
    
    let destination = [VacationDestination(name : "Street", location : CLLocationCoordinate2DMake(50.425951, 30.465074) , zoom : 18), VacationDestination(name: "My House", location: CLLocationCoordinate2DMake(50.359964, 30.430502), zoom : 18) ]
    
    
    
    
    override  func viewDidLoad() {
        super.viewDidLoad()
       // 50.454563, 30.386699
        
        // 50.425951, 30.465074
        // Do any additional setup after loading the view, typically from a nib.
        
        GMSServices.provideAPIKey("AIzaSyBjW96W7rCmSlIAJm0XUMoTUBsTV-GqPLM")
        
        let camera = GMSCameraPosition.camera(withLatitude: 50.454563, longitude: 30.386699, zoom: 18)
        
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
         view = mapView
        
        let currentLocation = CLLocationCoordinate2D(latitude: 50.454563 , longitude: 30.386699)
        let marker  = GMSMarker(position: currentLocation)
        
        marker.title = "Дом Лизы"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: "next")
        
    }
    func next() {
        
        if currentDestination == nil {
            
            currentDestination = destination.first
            
        
        }
        else {
            
            if   let index = destination.index(of: currentDestination!) {
                
                currentDestination = destination[index + 1]
                }
          
        }
        setMapCamera()
       // loadView()
        
        
        
    
    }
  
    private func setMapCamera() {
        
        CATransaction.begin()
        CATransaction.setValue(2, forKey: kCATransactionAnimationDuration)
        mapView?.animate(to: GMSCameraPosition.camera(withTarget: currentDestination!.location, zoom: (currentDestination?.zoom)!))
        
        
        CATransaction.commit()
        let marker  = GMSMarker(position: currentDestination!.location)
        marker.title = currentDestination?.name
        marker.map = mapView
        
        
        
    }
//        override func loadView() {
//        let panoView = GMSPanoramaView(frame: CGRect.zero)
//        self.view = panoView
//        
//        panoView.moveNearCoordinate(CLLocationCoordinate2DMake(50.359964, 30.430502))
//        
//    }
 

}
