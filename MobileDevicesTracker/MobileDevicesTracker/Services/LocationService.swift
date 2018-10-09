//
//  LocationService.swift
//  MobileDevicesTracker
//
//  Created by Vova on 10/5/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: class {
    func didGetUserLocationUpdate(_ userLocation: Coordinates)
    func didGetError(_ error: Error)
}

enum LocationAccessType {
    
    case always
    case whenInUse
    
    fileprivate var requestLocationType: CLAuthorizationStatus? {
        switch self {
        case .always:
            return CLAuthorizationStatus.authorizedAlways
        case .whenInUse:
            return CLAuthorizationStatus.authorizedWhenInUse
        }
    }
}


final class LocationService: NSObject {
    
    static let shared = LocationService()
    weak var delegate: LocationServiceDelegate?
    private let locationManager = CLLocationManager()
    private var coordinates: Coordinates?

    // MARK: - LifeCycle
    
    private override init() {
        super.init()
        locationManager.delegate = self
//        locationManager.allowsBackgroundLocationUpdates = true
//        locationManager.pausesLocationUpdatesAutomatically = false
    }
    
    private var requestAccessCompletion: ((Bool) -> ())?
    private var accessType: LocationAccessType = .always
    
    func requestAccessToLocation(_ accessType: LocationAccessType = .always, completion: ((Bool) -> ())? = nil) {
        
        self.accessType = accessType
        
        if CLLocationManager.authorizationStatus() == accessType.requestLocationType {
            completion?(true)
        } else {
            requestAccessCompletion = completion
            assert(locationManager.delegate != nil, "invalid process")
            
            switch accessType {
            case .always :
                locationManager.requestAlwaysAuthorization()
            case .whenInUse:
                locationManager.requestWhenInUseAuthorization()

            }
        }
    }
    func startLocationTracking() {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.startUpdatingLocation()
    }
}

// MARK: - Extensions

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else {
            return
        }
        
        coordinates = Coordinates(latitude: mostRecentLocation.coordinate.latitude,
                                  longitude: mostRecentLocation.coordinate.longitude)
        
        if let coordinates = coordinates {
            self.delegate?.didGetUserLocationUpdate(coordinates)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            return
        }
        requestAccessCompletion?(status == accessType.requestLocationType)
        requestAccessCompletion = nil
    }
}
