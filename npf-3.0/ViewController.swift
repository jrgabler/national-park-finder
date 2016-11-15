//
//  ViewController.swift
//  npf-3.0
//
//  Created by Julianna Gabler on 11/1/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var parks: [Park] = []
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        loadLocation()
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "data", ofType: "plist") {
            if let tempDict = NSDictionary(contentsOfFile: path){
                let tempArray = (tempDict.value(forKey: "parks") as! NSArray) as Array
                for dict in tempArray {
                    let area = dict["area"]! as! String
                    let dateFormed = dict["dateFormed"]! as! String
                    let parkDescription = dict["description"]! as! String
                    
                    let imageLink = dict["imageLink"]! as! String
                    let imageName = dict["imageName"]! as! String
                    let imageSize = dict["imageSize"]! as! String
                    let imageType = dict["imageType"]! as! String
                    
                    let link = dict["link"]! as! String
                    
                    let parkLocation = dict["parkLocation"]! as! String
                    let parkName = dict["parkName"]! as! String
                    
                    let latitude = (dict["latitude"]! as! NSString).doubleValue
                    let longitude = (dict["longitude"]! as! NSString).doubleValue
                    let location = CLLocation(latitude: latitude, longitude: longitude)
                    
                    let p = Park(
                        parkName: parkName,
                        parkLocation: parkLocation,
                        dateFormed: dateFormed,
                        area: area,
                        link: link,
                        location: location,
                        imageLink: imageLink,
                        imageName: imageName,
                        imageSize: imageSize,
                        imageType: imageType,
                        parkDescription: parkDescription
                    )
                    
                    parks.append(p)
                }
            }
        }
        
        //add to annotations
        for park in parks {
            mapView.addAnnotation(park)
        }
    }
}

