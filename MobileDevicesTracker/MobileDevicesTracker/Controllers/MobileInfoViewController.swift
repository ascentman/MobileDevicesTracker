//
//  ViewController.swift
//  MobileDevicesTracker
//
//  Created by Vova on 10/5/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import UIKit

final class MobileInfoViewController: UITableViewController {
    
    private var newDevice: Device?
    private var captureDate: CapturedDate?
    
    @IBOutlet weak var manufacturing: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var os: UILabel!
    
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationService.shared.requestAccessToLocation(.always) { (granted) in
            if granted {
                LocationService.shared.startLocationTracking()
            } else {
                print("error")
            }
        }
        
        let modelInfo = MobileDeviceInfo()
        captureDate = CapturedDate()
        newDevice = Device(with: modelInfo.getMobileDeviceInfo())
        if let captureDate = captureDate {
            newDevice?.dates.append(captureDate)
        }
        
        FirebaseService.shared.loadDataFromDb(basedOn: newDevice)
        
        FirebaseService.shared.updateTableView()
    
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
    }
    
    private func updateDeviceLocationWith(coordinates: Coordinates) {
        
        let newLocation = DeviceLocations(location: coordinates)
        self.captureDate?.locations.append(newLocation)
        FirebaseService.shared.dateRef.setValue(self.captureDate?.appendLocation())
    }
    
            // check if device Info obj created and stored on firebase? if so grab it, if no create and store
            // ask deviceInfo for selected date from new location - if yes - use it, if no create it
            // if Captured date created - add to deviceInfo, if retrived - just grab it for use
            // apped new location to CapturedDate
            // store on firebase - if device in in foreground - just call method to store
            // if in background - start UIBackground Task and store data on firease
}

extension MobileInfoViewController: LocationServiceDelegate {
    func didGetUserLocationUpdate(_ userLocation: Coordinates) {
        
        print(userLocation.latitude, userLocation.longitude)
        
        updateDeviceLocationWith(coordinates: userLocation)
//        let newLocation = DeviceLocations(location: userLocation)
//
//        let capturedDate = CapturedDate()
//        capturedDate.locations.append(newLocation)
        
    }

    func didGetError(_ error: Error) {
        print("error")
    }
}
