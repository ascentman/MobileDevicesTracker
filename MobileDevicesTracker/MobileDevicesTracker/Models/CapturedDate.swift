//
//  CapturedData.swift
//  MobileDevicesTracker
//
//  Created by Vova on 10/8/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import Foundation

class CapturedDate {
    
    var day: Int?
    var month: Int?
    var year: Int?
    
    var locations: [DeviceLocations] = []
    
    init() {
        if let timezone = TimeZone(abbreviation: "UTC") {
            let components = Calendar.current.dateComponents(in: timezone, from: Date())
            day = components.day ?? 1
            month = components.month ?? 1
            year = components.year ?? 2018
        }
    }
    
    init(with day: Int, month: Int, year: Int) {
        self.day = day
        self.month = month
        self.year = year
    }
    
    func toAnyObject() -> Any {
        return [
            "day": day as Any,
            "month": month as Any,
            "year": year as Any,
        ]
    }
    
    func appendLocation() -> Any {
        return [
            "locations" : locations.map({ $0.toAnyObject() })
        ]
    }
}
