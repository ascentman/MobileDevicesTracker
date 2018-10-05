//
//  ViewController.swift
//  MobileDevicesTracker
//
//  Created by Vova on 10/5/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    private var currentLocation = LocationService.shared.requestLocation()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let device = MobileDevice()
        let dict = device.getMobileDeviceInfo()
        print(dict)
    }
    
    @IBAction func clicked(_ sender: Any) {
        
        print(currentLocation.latitude, currentLocation.longitude) // first time always (0,0). Need some observer or I don't know(
        self.currentLocation = LocationService.shared.requestLocation()
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: currentLocation, span: span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
    }
}
