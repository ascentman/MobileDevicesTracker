//
//  LocationService.swift
//  MobileDevicesTracker
//
//  Created by Vova on 10/5/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    
    static let shared = LocationService()
    private let locationManager = CLLocationManager()
    private var coordinates: CLLocationCoordinate2D?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        setupLocationManager(locationManager)
    }
    
    func requestLocation() -> CLLocationCoordinate2D {
        locationManager.requestLocation()
        if let coordinates = coordinates {
            return coordinates
        }
        return CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
    // MARK: - Private
    
    private func setupLocationManager(_ locationManager: CLLocationManager) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        if #available(iOS 9, *) {
            locationManager.allowsBackgroundLocationUpdates = true
        }
    }
}

// MARK: - Extensions

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mostRecentLocation = locations.last else {
            return
        }
        coordinates = mostRecentLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
