//
//  ViewController.swift
//  MobileDevicesTracker
//
//  Created by Vova on 10/5/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import UIKit

final class MobileInfoViewController: UIViewController {

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let device = MobileDevice()
        
        LocationService.shared.requestAccessToLocation(.always) { (granted) in
            if granted {
                LocationService.shared.startLocationTracking()
            } else {
                print("error")
            }
        }
        
        LocationService.shared.delegate = self
        /*

         "Device type" : "",
         "Workplace" : "",
         "Inventory number" : "",
         "Project" : "",
         "Sticker" : "",
         "Department/Project device" : "",
         "Responsible person" : ""
         для цих полів треба додати буде введення інформації вручну з таблички наприклад з статичниси целами
         */

        let dict = device.getMobileDeviceInfo()
        print(dict)
        
    }
}

extension MobileInfoViewController: LocationServiceDelegate {
    func didGetUserLocationUpdate(_ userLocation: Coordinates) {
        var currentLocation = userLocation.getLocation()
    }

    func didGetError(_ error: Error) {
        print("error")
    }
}
