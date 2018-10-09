//
//  MobileDevice.swift
//  MobileDevicesTracker
//
//  Created by Vova on 10/5/18.
//  Copyright © 2018 Vova. All rights reserved.
//

import UIKit

enum DeviceTypeModel: String {
    case unknown = "unknown"
    
    case iPod5 = "iPod Touch 5"
    case iPod6 = "iPod Touch 6"
    
    case iPhone4 = "iPhone 4"
    case iPhone4S = "iPhone 4S"
    case iPhone5 = "iPhone 5"
    case iPhone5C = "iPhone 5C"
    case iPhone5S = "iPhone 5S"
    case iPhoneSE = "iPhone SE"
    case iPhone6 = "iPhone 6"
    case iPhone6Plus = "iPhone 6 Plus"
    case iPhone6S = "iPhone 6S"
    case iPhone6SPlus = "iPhone 6S Plus"
    case iPhone7 = "iPhone 7"
    case iPhone7Plus = "iPhone 7 Plus"
    case iPhone8 = "iPhone 8"
    case iPhone8Plus = "iPhone 8 Plus"
    case iPhoneX = "iPhone X"
    case iPhoneXS = "iPhone XS"
    case iPhoneXSMax = "iPhone XS Max"
    case iPhoneXR = "iPhone XR"
    
    case iPad2 = "iPad 2"
    case iPad3 = "iPad 3"
    case iPad4 = "iPad 4"
    case iPad5 = "iPad 5"
    case iPadAir = "iPad Air"
    case iPadAir2 = "iPad Air 2"
    case iPadMini = "iPad Mini"
    case iPadMini2 = "iPad Mini 2"
    case iPadMini3 = "iPad Mini 3"
    case iPadMini4 = "iPad Mini 4"
    case iPadPro = "iPad Pro"
    case iPadPro9Inch = "iPad Pro 9.7 Inch"
    case iPadPro10Inch = "iPad Pro 10.5 Inch"
    case iPadPro12Inch = "iPad Pro 12.9 Inch"
    case iPadPro12Inch2 = "iPad Pro 12.9 Inch 2. Generation"
    
    case appleTV = "Apple TV"
    case appleTV4k = "Apple TV 4K"
    
    case homePad = "HomePod"
    
    case simulator = "Simulator"
}


final class MobileDeviceInfo {
    
    private var manufactoring: String {
        return UIDevice.current.model
    }
    
    private var model: DeviceTypeModel {
        let name = UIDevice.current.name
        switch name {
        case "iPod Touch 5":
            return .iPod5
        case "iPod Touch 6":
            return .iPod6
        case "iPhone 4":
            return .iPhone4
        case "iPhone 4s":
            return .iPhone4S
        case "iPhone 5":
            return .iPhone5
        case "iPhone 5c":
            return .iPhone5C
        case "iPhone 5s":
            return .iPhone5S
        case "iPhone 5se":
            return .iPhoneSE
        case "iPhone 6":
            return .iPhone6
        case "iPhone 6 Plus":
            return .iPhone6Plus
        case "iPhone 6s":
            return .iPhone6S
        case "iPhone 6s Plus":
            return .iPhone6SPlus
        case "iPhone 7":
            return .iPhone7
        case "iPhone 7 Plus":
            return .iPhone7Plus
        case "iPad 2":
            return .iPad2
        case "iPad 3":
            return .iPad3
        case "iPad 4":
            return .iPad4
        case "iPad Air":
            return .iPadAir
        case "iPad Air 2":
            return .iPadAir2
        case "iPad Mini":
            return .iPadMini
        case "iPad Mini 2":
            return .iPadMini2
        case "iPad Mini 3":
            return .iPadMini3
        case "iPad Mini 4":
            return .iPadMini4
        case "iPad Pro":
            return .iPadPro
        case "Apple TV":
            return .appleTV
        case "iPhone 8":
            return .iPhone8
        case "iPhone 8 Plus":
            return .iPhone8Plus
        case "iPhone X":
            return .iPhoneX
        case "iPhone XR":
            return .iPhoneXR
        case "iPhone XS":
            return .iPhoneXS
        case "iPhone XS Max":
            return .iPhoneXSMax
        case "iPad 5":
            return .iPad5
        case "iPad Pro 9.7 Inch":
            return .iPadPro9Inch
        case "iPad Pro 12.9 Inch":
            return .iPadPro12Inch
        case "iPad Pro 12.9 Inch 2. Generation":
            return .iPadPro12Inch2
        case "iPad Pro 10.5 Inch":
            return .iPadPro10Inch
        case "Apple TV 4K":
            return .appleTV4k
        case "HomePod":
            return .homePad
        case "Simulator":
            return .simulator
            
        default:
            return .unknown
        }
    }
    
    private var OS: String {
        return UIDevice.current.systemName
    }
    
    private var screenResolution: String {
        return "\(Int(UIScreen.main.nativeBounds.height)) x \(Int(UIScreen.main.nativeBounds.width))"
    }
    
    private var screenRatio: String {
        let oldIphones: [DeviceTypeModel] = [.iPhone4, .iPhone4S]
        let newerIphones: [DeviceTypeModel] = [.iPhone5, .iPhone5C, .iPhone5S, .iPhoneSE,
                                               .iPhone6, .iPhone6Plus, .iPhone6S, .iPhone6SPlus,
                                               .iPhone7, .iPhone7Plus, .iPhone8, .iPhone8Plus,
                                               .iPhoneX, .iPhoneXS, .iPhoneXSMax, .iPhoneXR]
        let ipads: [DeviceTypeModel] = [.iPad2, .iPad3, .iPad4, .iPad5,
                                          .iPadAir, .iPadAir2,
                                          .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4,
                                          .iPadPro, .iPadPro9Inch, .iPadPro10Inch, .iPadPro12Inch, .iPadPro12Inch2]
        switch model {
        case let model where oldIphones.contains(model):
            return "3:2"
        case let model where ipads.contains(model):
            return "4:3"
        case let model where newerIphones.contains(model):
            return "16:9"
        default:
             return "unknown"
        }
    }
    
    // uniquely identifies a device to the app’s vendor
    private var uniqueId: String {
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            return uuid
        } else {
            return ""
        }
    }
    
    func getMobileDeviceInfo() -> [String : Any] {
        let dictInfo: [String : Any] = [
            "manufactoring" : self.manufactoring,
            "model" : self.model.rawValue,
            "OS" : self.OS,
            "Screen resolution" : self.screenResolution,
            "Screen ratio" : self.screenRatio,
            "UUID" : self.uniqueId,
            "Serial number" : "",
            "MAC address" : "",
            "IMEI" : "",
            "Device type" : "",
            "Workplace" : "",
            "Inventory number" : "",
            "Project" : "",
            "Sticker" : "",
            "Department or Project device" : "",
            "Responsible person" : ""
        ]
        
        return dictInfo
    }
    /**
     https://developer.apple.com/library/archive/releasenotes/General/WhatsNewIniOS/Articles/iOS7.html#//apple_ref/doc/uid/TP40013162-SW1
     In iOS 7 and later, if you ask for the MAC address of an iOS device, the system returns the value 02:00:00:00:00:00. If you need to identify the device, use the identifierForVendor property of UIDevice instead.
     
     https://discussions.apple.com/thread/7574711?answerId=30261762022#30261762022
     For privacy reasons, Apple doesn't want you to retrieve any device specific information such as IMEI, UDID, MAC address, serial number, etc, and has been removing support for this kind of information from the SDK for a while now. Your application will be rejected if you try to use private methods, so that is probably what they were talking about.
     
     The only exception is on managed devices, where MDM has access to this sort of thing
     */
}
