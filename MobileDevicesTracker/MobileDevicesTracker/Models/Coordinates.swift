//
//  Coordinates.swift
//  MobileDevicesTracker
//
//  Created by Vova on 10/8/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import Foundation

final class Coordinates {
    private (set) var latitude: Double
    private (set) var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
