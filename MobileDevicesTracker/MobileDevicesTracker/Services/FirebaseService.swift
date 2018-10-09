//
//  FirebaseService.swift
//  MobileDevicesTracker
//
//  Created by Vova on 10/9/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import UIKit
import Firebase

final class FirebaseService {
    
    static let shared = FirebaseService()
    private init() {}
    
    let devicesRef = Database.database().reference(withPath: "Devices")
    let deviceRef = Database.database().reference(withPath: "Devices/Device")
    let datesRef = Database.database().reference(withPath: "Devices/Device/Dates")
    let dateRef = Database.database().reference(withPath: "Devices/Device/Dates/Date")
    let locationRef = Database.database().reference(withPath: "Devices/Device/Dates/Locations")
    
    @discardableResult class func registerInApplication(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func loadDataFromDb(basedOn device: Device?) {
        guard let device = device else {
            return
        }
        
//        devicesRef.child("Device").queryEqual(toValue: device.uuid).observeSingleEvent(of: .value) { (snapshot) in
//            print(snapshot)
//        }
        
        deviceRef.child("uuid").observe(.value) { (uuidSnap) in
            if uuidSnap.value as? String == device.uuid {
                print("exist!!!!!!!!!!")
            } else {
                print("not exist!!!!!!!!!!")
                self.deviceRef.setValue(device.toAnyObject())
            }
        }
    }
    
    func updateLocations(basedOn device: Device) {
        devicesRef.setValue(device.toAnyObject())
    }
    
//    func updateLocations(basedOn dates: DeviceLocations) {
//        
//        datesRef.observe(.value) { (snapshot) in
//            if let snaps = snapshot.children.allObjects as? [DataSnapshot] {
//                for child in snaps {
//                    guard let dict = child.value as? [String : Any] else {
//                        return
//                    }
//                    if dates.day == dict["day"] as? Int,
//                        dates.month == dict["month"] as? Int,
//                        dates.year == dict["year"] as? Int {
//                        
//                        let cap = CapturedDate()
//                        cap.locations.append(dates)
//                    }
//                }
//            }
//        }
//    }
}
