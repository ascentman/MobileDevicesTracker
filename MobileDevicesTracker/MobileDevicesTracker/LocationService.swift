//
//  LocationService.swift
//  MobileDevicesTracker
//
//  Created by Vova on 10/5/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import Foundation
import CoreLocation

// можна ж додати делегат і потім його обробити у контролері типу
protocol LocationServiceDelegate: class {
    func didGetUserLocationUpdate(_ userLocation: CLLocation)
    func didGetError(_ error: Error)

}

final class LocationService: NSObject {

    weak var delegate: LocationServiceDelegate?
    
    static let shared = LocationService()
    private let locationManager = CLLocationManager()
    private var coordinates: CLLocationCoordinate2D?

    // MARK: - LifeCycle
    
    private override init() {
        super.init()

        locationManager.delegate = self

        setupLocationManager(locationManager)
    }

    // треба метод для запиту дозволу на локацію ОКРЕМО
    // є метод делагут для отримання feedback
    //    optional public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)

    //  якшо прямо так як ти робиш в init - тоді ти не контролюєш цей момент взагалі і запит відразу виконується як створюєш обєкт, а що робити коли треба по натисканню кнопки показати попап - з такою логікою не вийде
    // короч окремий метод з completion
    

    func requestLocation() -> CLLocationCoordinate2D {
        locationManager.requestLocation()
        if let coordinates = coordinates {
            return coordinates
        }
        // а тут і причина чого ти 0,0 отримуєш - бо coordinates nil адже треба певний час на отримання локаціїї
        return CLLocationCoordinate2D(latitude: 0, longitude: 0)
    }
    
    // MARK: - Private
    
    private func setupLocationManager(_ locationManager: CLLocationManager) {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 500
        if CLLocationManager.authorizationStatus() != .authorizedAlways
        {
            locationManager.requestAlwaysAuthorization()
        } else {
            locationManager.startUpdatingLocation()
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
