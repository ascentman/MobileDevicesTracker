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
    
    @IBOutlet weak var systemTextView: UITextView!
    @IBOutlet weak var respPersonTextField: UITextField!
    @IBOutlet weak var projectTextField: UITextField!
    
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
        
        FirebaseService.shared.loadDataFromDb()
        FirebaseService.shared.ref?.observe(.value, with: { (snapshot) in
            guard let dict = snapshot.value as? [String: Any] else {
                return
            }
            let jsonData = dict.dict2json()
            self.systemTextView.text = jsonData
        })
        
        LocationService.shared.delegate = self
        respPersonTextField.delegate = self
    }
    
    // MARK: - IBActions
    
    @IBAction func savePressed(_ sender: Any) {
        let proj = projectTextField.text
        let resp = respPersonTextField.text
        FirebaseService.shared.saveUserData(proj: proj, resp: resp)
    }
    
    private func updateDeviceLocationWith(coordinates: Coordinates) {
        
        let newLocation = DeviceLocations(location: coordinates)
        FirebaseService.shared.updateLocations(basedOn: newLocation)
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

// MARK: - Extensions
//TODO: move in separate files

extension Dictionary {
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
    func dict2json() -> String {
        return json
    }
}

extension MobileInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
