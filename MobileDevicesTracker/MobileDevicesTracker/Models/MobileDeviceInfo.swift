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
    
    var modelName: String {
        var machineString: String = ""
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        machineString = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch machineString {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone 5se"
        case "iPhone9,1":                               return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return machineString
        }
    }
    
    private var name: String {
        return UIDevice.current.name
    }
    
    private var os: String {
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
        if let model = DeviceTypeModel(rawValue: self.modelName) {
            switch model {
            case let model where oldIphones.contains(model):
                return "3:2"
            case let model where ipads.contains(model):
                return "4:3"
            case let model where newerIphones.contains(model):
                return "16:9"
            default:
                break
            }
        }
        return "unknown"
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
            "model" : self.modelName,
            "OS" : self.os,
            "name" : self.name,
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
