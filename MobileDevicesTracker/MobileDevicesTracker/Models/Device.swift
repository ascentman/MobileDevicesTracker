//
//  Device.swift
//  MobileDevicesTracker
//
//  Created by Vova on 10/9/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import Foundation
import Firebase

final class Device {

    var manufactoring: String
    var model: String
    var os: String
    var name: String
    private var screenResolution: String
    private var screenRatio: String
    var uuid: String
    private var serialNumber: String
    private var macAddress: String
    private var imei: String
    private var deviceType: String
    private var workplace: String
    private var inventoryNumber: String
    private var project: String
    private var sticker: String
    private var department: String
    private var responsiblePerson: String

    var dates: [CapturedDate] = []
    
    init?(with value: [String : Any]) {
        guard let manufactoring = value["manufactoring"] as? String,
            let model = value["model"] as? String,
            let os = value["OS"] as? String,
            let name = value["name"] as? String,
            let screenResolution = value["Screen resolution"] as? String,
            let screenRatio = value["Screen ratio"] as? String,
            let uuid = value["UUID"] as? String,
            let serialNumber = value["Serial number"] as? String,
            let macAddress = value["MAC address"] as? String,
            let imei = value["IMEI"] as? String,
            let deviceType = value["Device type"] as? String,
            let workplace = value["Workplace"] as? String,
            let inventoryNumber = value["Inventory number"] as? String,
            let project = value["Project"] as? String,
            let sticker = value["Sticker"] as? String,
            let department = value["Department or Project device"] as? String,
            let responsiblePerson = value["Responsible person"] as? String else {
                return nil
        }
        
        self.manufactoring = manufactoring
        self.model = model
        self.os = os
        self.name = name
        self.screenResolution = screenResolution
        self.screenRatio = screenRatio
        self.uuid = uuid
        self.serialNumber = serialNumber
        self.macAddress = macAddress
        self.imei = imei
        self.deviceType = deviceType
        self.workplace = workplace
        self.inventoryNumber = inventoryNumber
        self.project = project
        self.sticker = sticker
        self.department = department
        self.responsiblePerson = responsiblePerson
    }
    
    func toAnyObject() -> Any {
        return [
            "manufactoring": manufactoring,
            "model": model,
            "os": os,
            "name" : name,
            "screenResolution" : screenResolution,
            "screenRatio" : screenRatio,
            "uuid" : uuid
//            "serialNumber" : serialNumber,
//            "macAddress" : macAddress,
//            "imei" : imei,
//            "deviceType" : deviceType,
//            "workplace" : workplace,
//            "inventoryNumber" : inventoryNumber,
//            "project" : project,
//            "sticker" : sticker,
//            "department" : department,
//            "responsiblePerson" : responsiblePerson
            //"Dates" : dates.map({ $0.toAnyObject() })
        ]
    }
}
