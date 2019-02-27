//
//  Locations.swift
//  MobileDevicesTracker
//
//  Created by Vova on 10/8/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import Foundation

final class DeviceLocations {
    private (set) var location: Coordinates
    private (set) var date: String
    
    var day: Int? {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MMMM/yyyy HH:mm"
            if let receivedDate = formatter.date(from: self.date) {
                formatter.dateFormat = "dd"
                let dateString = formatter.string(from: receivedDate)
                let day = Int(dateString)
                assert(day != nil, "invalid day conversion")
                return day
            }
            assertionFailure("invalid day convertion")
            return nil
        }
    }
    
    var month: Int? {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MMMM/yyyy HH:mm"
            if let receivedDate = formatter.date(from: self.date) {
                formatter.dateFormat = "MM"
                let dateString = formatter.string(from: receivedDate)
                let month = Int(dateString)
                assert(month != nil, "invalid month conversion")
                return month
            }
            assertionFailure("invalid month convertion")
            return nil
        }
    }
    
    var year: Int? {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MMMM/yyyy HH:mm"
            if let receivedDate = formatter.date(from: self.date) {
                formatter.dateFormat = "yyyy"
                let dateString = formatter.string(from: receivedDate)
                let year = Int(dateString)
                assert(year != nil, "invalid year conversion")
                return year
            }
            assertionFailure("invalid year convertion")
            return nil
        }
    }
    
    init(location: Coordinates) {
        self.location = location
        
        let dateObj = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MMMM/yyyy HH:mm"
        self.date = formatter.string(from: dateObj)
    }
    
    func toAnyObject() -> Any {
        return [
            "latitude" : location.latitude,
            "longitude" : location.longitude,
            "time": date
        ]
    }
}

