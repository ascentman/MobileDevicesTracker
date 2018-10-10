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
    var ref: DatabaseReference?
    
    @discardableResult class func registerInApplication(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func loadDataFromDb() {
        
        let modelInfo = MobileDeviceInfo()
        guard let device = Device(with: modelInfo.getMobileDeviceInfo()) else {
            return
        }
        self.ref = devicesRef.child("\(device.uuid)")
        if let ref = self.ref {
            ref.observeSingleEvent(of: .value) { snapshot in
                if snapshot.exists() {
                    //
                } else {
                    ref.updateChildValues(["SystemInfo" : device.toAnyObject()])
                }
            }
        }
    }
    
    func updateLocations(basedOn newLocation: DeviceLocations) {
        let currentDate = CapturedDate()
        let dateString = "\(currentDate.year!):\(currentDate.month!):\(currentDate.day!)"

        if let ref = self.ref {
            let currentDateRef = ref.child("\(dateString)")
            currentDateRef.observeSingleEvent(of: .value, with: { currentDateValue in
                currentDateRef.childByAutoId().setValue(newLocation.toAnyObject())
            })
        }
    }
    
    func saveUserData(proj: String?, resp: String?) {
        
        let dict = ["project" : proj,
                    "responsiblePerson" : resp
        ]
        if let ref = self.ref {
            ref.updateChildValues(["ManualInfo" : dict])
        }
    }
}
