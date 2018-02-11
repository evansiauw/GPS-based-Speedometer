//
//  MapViewController.swift
//  MyFirstApp
//
//  Created by Iwan Siauw on 8/19/17.
//  Copyright © 2017 Iwan Siauw. All rights reserved.
//

import UIKit
import CoreLocation // must import to use map
import MapKit // must import to use map

class MapViewController: UIViewController, CLLocationManagerDelegate {

   
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    let manager = CLLocationManager()

    @IBAction func stopLoading(_ sender: Any) {
        manager.stopUpdatingLocation()
    }
    
    func setCenterOfMapToLocation(location: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
    }

    func addPinToMapView (){
        let workPlace = CLLocationCoordinate2DMake(40.756220040, -73.9672300)
        let annotation = MKPointAnnotation()
        annotation.coordinate = workPlace
        annotation.title = "Tenzan52";
        map.addAnnotation(annotation);
        // setCenterOfMapToLocation(location: workPlace)
        
    }
    
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
    let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
    let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
    let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
    
    map.setRegion(region, animated: true)
        print (location.coordinate)
        print (location.speed * 2.236936284)
        
        self.map.showsUserLocation = true
    
    speedLabel.text = String(format: "%.0f", location.speed * 2.236936284)
    
    
    if location.speed * 2.236936284 <= 20 {
        speedLabel.backgroundColor = UIColor.blue
    }
    else { speedLabel.backgroundColor = UIColor.red
          // blink();
    }
    
    }
    
    /*func blink (){
        
        var timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(blink)), userInfo: nil, repeats: true)
        var blinkStatus = false;
        
        if(blinkStatus == false){
            speedLabel.backgroundColor = UIColor.white;
            blinkStatus = true; }
        else {
            speedLabel.backgroundColor = UIColor.red;
            blinkStatus = false; }
    } */
    
    @IBAction func LocateMe(_ sender: UIBarButtonItem) {
        
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation() }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPinToMapView()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
}
