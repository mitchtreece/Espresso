//
//  UIDevice+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

public extension UIDevice /* Info*/ {
    
    /// Representation of the various iOS device types.
    ///
    /// Also provides information about the current device's system & state.
    enum DeviceInfo: String, CaseIterable {
        
        // iPhone
        
        case iPhone
        case iPhone3G
        case iPhone3GS
        case iPhone4
        case iPhone4S
        case iPhone5
        case iPhone5C
        case iPhone5S
        case iPhone6
        case iPhone6Plus
        case iPhone6S
        case iPhone6SPlus
        case iPhoneSE
        case iPhone7
        case iPhone7Plus
        case iPhone8
        case iPhone8Plus
        case iPhoneX
        case iPhoneXR
        case iPhoneXS
        case iPhoneXSMax
        case iPhone11
        case iPhone11Pro
        case iPhone11ProMax
        case iPhoneSE_2
        case iPhone12
        case iPhone12Mini
        case iPhone12Pro
        case iPhone12ProMax
        case iPhone13
        case iPhone13Mini
        case iPhone13Pro
        case iPhone13ProMax
        case iPhoneSE_3
        
        // iPod Touch
        
        case iPodTouch
        case iPodTouch_2
        case iPodTouch_3
        case iPodTouch_4
        case iPodTouch_5
        case iPodTouch_6
        case iPodTouch_7
        
        // iPad
        
        case iPad
        case iPad3G
        case iPad_2
        case iPad_3
        case iPadMini
        case iPad_4
        case iPadAir
        case iPadMini_2
        case iPadMini_3
        case iPadMini_4
        case iPadAir_2
        case iPadPro9
        case iPadPro12
        case iPad_5
        case iPadPro12_2
        case iPadPro10
        case iPad_6
        case iPad_7
        case iPadPro11
        case iPadPro12_3
        case iPadPro11_2
        case iPadPro12_4
        case iPadMini_5
        case iPadAir_3
        case iPad_8
        case iPadAir_4
        case iPadPro11_3
        case iPadPro12_5
        case iPad_9
        case iPadMini_6
        case iPadAir_5

        // Watch
        
        case appleWatch
        case appleWatchS1
        case appleWatchS2
        case appleWatchS3
        case appleWatchS4
        case appleWatchS5
        case appleWatchSE
        case appleWatchS6
        case appleWatchS7
        
        // Apple TV
        
        case appleTV
        case appleTV_2
        case appleTV_3
        case appleTV_4
        case appleTV4K
        case appleTV4K_2
        
        // AirTag
        
        case airtag
        
        // AirPods
        
        case airpods
        case airpods_2
        case airpodsPro
        case airpodsMax
        
        // HomePod
        
        case homepod
        case homepodMini
        
        // Other
        
        case simulator
        case unknown
        
        /// The device's display name.
        public var displayName: String {
            
            switch self {
            case .iPhone: return "iPhone"
            case .iPhone3G: return "iPhone 3G"
            case .iPhone3GS: return "iPhone 3GS"
            case .iPhone4: return "iPhone 4"
            case .iPhone4S: return "iPhone 4S"
            case .iPhone5: return "iPhone 5"
            case .iPhone5C: return "iPhone 5c"
            case .iPhone5S: return "iPhone 5s"
            case .iPhone6: return "iPhone 6"
            case .iPhone6Plus: return "iPhone 6 Plus"
            case .iPhone6S: return "iPhone 6s"
            case .iPhone6SPlus: return "iPhone 6s Plus"
            case .iPhoneSE: return "iPhone SE"
            case .iPhone7: return "iPhone 7"
            case .iPhone7Plus: return "iPhone 7 Plus"
            case .iPhone8: return "iPhone 8"
            case .iPhone8Plus: return "iPhone 8 Plus"
            case .iPhoneX: return "iPhone X"
            case .iPhoneXR: return "iPhone XR"
            case .iPhoneXS: return "iPhone XS"
            case .iPhoneXSMax: return "iPhone XS Max"
            case .iPhone11: return  "iPhone 11"
            case .iPhone11Pro: return "iPhone 11 Pro"
            case .iPhone11ProMax: return "iPhone 11 Pro Max"
            case .iPhoneSE_2: return "iPhone SE (2nd Gen)"
            case .iPhone12: return "iPhone 12"
            case .iPhone12Mini: return "iPhone 12 mini"
            case .iPhone12Pro: return "iPhone 12 Pro"
            case .iPhone12ProMax: return "iPhone 12 Pro Max"
            case .iPhone13: return "iPhone 13"
            case .iPhone13Mini: return "iPhone 13 mini"
            case .iPhone13Pro: return "iPhone 13 Pro"
            case .iPhone13ProMax: return "iPhone 13 Pro Max"
            case .iPhoneSE_3: return "iPhone SE (3rd Gen)"
                
            case .iPodTouch: return "iPod touch"
            case .iPodTouch_2: return "iPod touch (2nd Gen)"
            case .iPodTouch_3: return "iPod touch (3rd Gen)"
            case .iPodTouch_4: return "iPod touch (4th Gen)"
            case .iPodTouch_5: return "iPod touch (5th Gen)"
            case .iPodTouch_6: return "iPod touch (6th Gen)"
            case .iPodTouch_7: return "iPod touch (7th Gen)"
                
            case .iPad: return "iPad"
            case .iPad3G: return "iPad 3G"
            case .iPad_2: return "iPad (2nd Gen)"
            case .iPad_3: return "iPad (3rd Gen)"
            case .iPadMini: return "iPad mini"
            case .iPad_4: return "iPad (4th Gen)"
            case .iPadAir: return "iPad Air"
            case .iPadMini_2: return "iPad mini (2nd Gen)"
            case .iPadMini_3: return "iPad mini (3rd Gen)"
            case .iPadMini_4: return "iPad mini (4th Gen)"
            case .iPadAir_2: return "iPad Air (2nd Gen)"
            case .iPadPro9: return "iPad Pro (9-inch)"
            case .iPadPro12: return "iPad Pro (12.9-inch)"
            case .iPad_5: return "iPad (5th Gen)"
            case .iPadPro12_2: return "iPad Pro (12.9-inch) (2nd Gen)"
            case .iPadPro10: return "iPad Pro (10.5-inch)"
            case .iPad_6: return "iPad (6th Gen)"
            case .iPad_7: return "iPad (7th Gen)"
            case .iPadPro11: return "iPad Pro (11-inch)"
            case .iPadPro12_3: return "iPad Pro (12.9-inch) (3rd Gen)"
            case .iPadPro11_2: return "iPad Pro (11-inch) (2nd Gen)"
            case .iPadPro12_4: return "iPad Pro (12.9-inch) (4th Gen)"
            case .iPadMini_5: return "iPad mini (5th Gen)"
            case .iPadAir_3: return "iPad Air (3rd Gen)"
            case .iPad_8: return "iPad (8th Gen)"
            case .iPadAir_4: return "iPad Air (4th Gen)"
            case .iPadPro11_3: return "iPad Pro (11-inch) (3rd Gen)"
            case .iPadPro12_5: return "iPad Pro (12.9-inch) (5th Gen)"
            case .iPad_9: return "iPad (9th Gen)"
            case .iPadMini_6: return "iPad mini (6th Gen)"
            case .iPadAir_5: return "iPad Air (5th Gen)"
                
            case .appleWatch: return "Apple Watch"
            case .appleWatchS1: return "Apple Watch Series 1"
            case .appleWatchS2: return "Apple Watch Series 2"
            case .appleWatchS3: return "Apple Watch Series 3"
            case .appleWatchS4: return "Apple Watch Series 4"
            case .appleWatchS5: return "Apple Watch Series 5"
            case .appleWatchSE: return "Apple Watch SE"
            case .appleWatchS6: return "Apple Watch Series 6"
            case .appleWatchS7: return "Apple Watch Series 7"
                
            case .appleTV: return "Apple TV"
            case .appleTV_2: return "Apple TV (2nd Gen)"
            case .appleTV_3: return "Apple TV (3nd Gen)"
            case .appleTV_4: return "Apple TV (4nd Gen)"
            case .appleTV4K: return "Apple TV 4K"
            case .appleTV4K_2: return "Apple TV 4K (2nd Gen)"
                        
            case .airtag: return "AirTag"
                        
            case .airpods: return "AirPods"
            case .airpods_2: return "AirPods (2nd Gen)"
            case .airpodsPro: return "AirPods Pro"
            case .airpodsMax: return "AirPods Max"
                
            case .homepod: return "HomePod"
            case .homepodMini: return "HomePod mini"
                
            case .simulator: return "Simulator"
            case .unknown: return "Unknown"
            }
            
        }
        
        internal var identifiers: [String] {
            
            switch self {
            case .iPhone: return ["iPhone1,1"]
            case .iPhone3G: return ["iPhone1,2"]
            case .iPhone3GS: return ["iPhone2,1"]
            case .iPhone4: return ["iPhone3,1", "iPhone3,2", "iPhone3,3"]
            case .iPhone4S: return ["iPhone4,1"]
            case .iPhone5: return ["iPhone5,1", "iPhone5,2"]
            case .iPhone5C: return ["iPhone5,3", "iPhone5,4"]
            case .iPhone5S: return ["iPhone6,1", "iPhone6,2"]
            case .iPhone6: return ["iPhone7,2"]
            case .iPhone6Plus: return ["iPhone7,1"]
            case .iPhone6S: return ["iPhone8,1"]
            case .iPhone6SPlus: return ["iPhone8,2"]
            case .iPhoneSE: return ["iPhone8,4"]
            case .iPhone7: return ["iPhone9,1", "iPhone9,3"]
            case .iPhone7Plus: return ["iPhone9,2", "iPhone9,4"]
            case .iPhone8: return ["iPhone10,1", "iPhone10,4"]
            case .iPhone8Plus: return ["iPhone10,2", "iPhone10,5"]
            case .iPhoneX: return ["iPhone10,3", "iPhone10,6"]
            case .iPhoneXR: return ["iPhone11,8"]
            case .iPhoneXS: return ["iPhone11,2"]
            case .iPhoneXSMax: return ["iPhone11,4", "iPhone11,6"]
            case .iPhone11: return ["iPhone12,1"]
            case .iPhone11Pro: return ["iPhone12,3"]
            case .iPhone11ProMax: return ["iPhone12,5"]
            case .iPhoneSE_2: return ["iPhone12,8"]
            case .iPhone12: return ["iPhone13,2"]
            case .iPhone12Mini: return ["iPhone13,1"]
            case .iPhone12Pro: return ["iPhone13,3"]
            case .iPhone12ProMax: return ["iPhone13,4"]
            case .iPhone13: return ["iPhone14,5"]
            case .iPhone13Mini: return ["iPhone14,4"]
            case .iPhone13Pro: return ["iPhone14,2"]
            case .iPhone13ProMax: return ["iPhone14,3"]
            case .iPhoneSE_3: return ["iPhone14,6"]
                
            case .iPodTouch: return ["iPod1,1"]
            case .iPodTouch_2: return ["iPod2,1"]
            case .iPodTouch_3: return ["iPod3,1"]
            case .iPodTouch_4: return ["iPod4,1"]
            case .iPodTouch_5: return ["iPod5,1"]
            case .iPodTouch_6: return ["iPod7,1"]
            case .iPodTouch_7: return ["iPod9,1"]
                
            case .iPad: return ["iPad1,1"]
            case .iPad3G: return ["iPad1,2"]
            case .iPad_2: return ["iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4"]
            case .iPad_3: return ["iPad3,1", "iPad3,2", "iPad3,3"]
            case .iPadMini: return ["iPad2,5", "iPad2,6", "iPad2,7"]
            case .iPad_4: return ["iPad3,4", "iPad3,5", "iPad3,6"]
            case .iPadAir: return ["iPad4,1", "iPad4,2", "iPad4,3"]
            case .iPadMini_2: return ["iPad4,4", "iPad4,5", "iPad4,6"]
            case .iPadMini_3: return ["iPad4,7", "iPad4,8", "iPad4,9"]
            case .iPadMini_4: return ["iPad5,1", "iPad5,2"]
            case .iPadAir_2: return ["iPad5,3", "iPad5,4"]
            case .iPadPro9: return ["iPad6,3", "iPad6,4"]
            case .iPadPro12: return ["iPad6,7", "iPad6,8"]
            case .iPad_5: return ["iPad6,11", "iPad6,12"]
            case .iPadPro12_2: return ["iPad7,1", "iPad7,2"]
            case .iPadPro10: return ["iPad7,3", "iPad7,4"]
            case .iPad_6: return ["iPad7,5", "iPad7,6"]
            case .iPad_7: return ["iPad7,11", "iPad7,12"]
            case .iPadPro11: return ["iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4"]
            case .iPadPro12_3: return ["iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8"]
            case .iPadPro11_2: return ["iPad8,9", "iPad8,10"]
            case .iPadPro12_4: return ["iPad8,11", "iPad8,12"]
            case .iPadMini_5: return ["iPad11,1", "iPad11,2"]
            case .iPadAir_3: return ["iPad11,3", "iPad11,4"]
            case .iPad_8: return ["iPad11,6", "iPad11,7"]
            case .iPadAir_4: return ["iPad13,1", "iPad13,2"]
            case .iPadPro11_3: return ["iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7"]
            case .iPadPro12_5: return ["iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11"]
            case .iPad_9: return ["iPad12,1", "iPad12,2"]
            case .iPadMini_6: return ["iPad14,1", "iPad14,2"]
            case .iPadAir_5: return ["iPad13,6", "iPad13,7"]
                
            case .appleWatch: return ["Watch1,1", "Watch1,2"]
            case .appleWatchS1: return ["Watch2,6", "Watch2,7"]
            case .appleWatchS2: return ["Watch2,3", "Watch2,4"]
            case .appleWatchS3: return ["Watch3,1", "Watch3,2", "Watch3,3", "Watch3,4"]
            case .appleWatchS4: return ["Watch4,1", "Watch4,2", "Watch4,3", "Watch4,4"]
            case .appleWatchS5: return ["Watch5,1", "Watch5,2", "Watch5,3", "Watch5,4"]
            case .appleWatchS6: return ["Watch6,1", "Watch6,2", "Watch6,3", "Watch6,4"]
            case .appleWatchSE: return ["Watch5,9", "Watch5,10", "Watch5,11", "Watch5,12"]
            case .appleWatchS7: return ["Watch6,6", "Watch6,7", "Watch6,8", "Watch6,9"]
                
            case .appleTV: return ["AppleTV1,1"]
            case .appleTV_2: return ["AppleTV2,1"]
            case .appleTV_3: return ["AppleTV3,1", "AppleTV3,2"]
            case .appleTV_4: return ["AppleTV5,3"]
            case .appleTV4K: return ["AppleTV6,2"]
            case .appleTV4K_2: return ["AppleTV11,1"]
                
            case .airtag: return ["AirTag1,1"]
                        
            case .airpods: return ["AirPods1,1"]
            case .airpods_2: return ["AirPods2,1"]
            case .airpodsPro: return ["AirPods2,2", "iProd8,1"]
            case .airpodsMax: return ["iProd8,6"]
                
            case .homepod: return ["AudioAccessory1,1", "AudioAccessory1,2"]
            case .homepodMini: return ["AudioAccessory5,1"]
            
            case .simulator: return ["i386", "x86_64", "arm64"]
            case .unknown: return []
            }
            
        }
        
        /// The device's system version string.
        public var systemVersion: String {
            return UIDevice.current.systemVersion
        }
        
        /// Flag indicating whether the current device is jailbroken or not.
        ///
        /// This is a simple check, and is **not** guaranteed to be 100% accurate.
        public var isJailbroken: Bool {
            
            guard !UIDevice.current.isSimulator else { return false }
            
            // 1: Check for common jailbroken files
            
            let fm = FileManager.default
            
            if fm.fileExists(atPath: "/Applications/Cydia.app") ||
                fm.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib") ||
                fm.fileExists(atPath: "/bin/bash") ||
                fm.fileExists(atPath: "/usr/sbin/sshd") ||
                fm.fileExists(atPath: "/etc/apt") ||
                fm.fileExists(atPath: "/private/var/lib/apt/") ||
                UIApplication.shared.canOpenURL(URL(string: "cydia://package/com.example.package")!) {
                
                    return true
                
            }
            
            // 2: Check for sandbox violation
            
            do {
                try "jailbroken".write(toFile: "/private/jailbroken.txt", atomically: true, encoding: .utf8)
                return true
            }
            catch {
                return false
            }
            
        }
        
        internal init(identifier: String) {
            
            for type in DeviceInfo.allCases {
                for id in type.identifiers {
                    
                    guard identifier == id else { continue }
                    self = type
                    return
                    
                }
            }
            
            self = .unknown
            
        }
        
    }
    
    /// Creates a new device info object, optionally overlooking the simulator if desired.
    /// - parameter includeSimulator: Flag indicating whether the `simulator` device type should be reported or not.
    /// If the current device is a simulator and this is set to _false_, the emulated device will be returned instead.
    /// - returns: A new device info object.
    func info(includeSimulator: Bool = false) -> DeviceInfo {
        
        #if targetEnvironment(simulator)
            let isSimulator = true
        #else
            let isSimulator = false
        #endif
        
        var machineIdentifier: String = ""
        
        if isSimulator && !includeSimulator {
            
            // We're running on the simulator, but we want to
            // return the device the simulator is emulating
            
            if let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                machineIdentifier = identifier
            }
            
        }
        else {
            
            var systemInfo = utsname()
            uname(&systemInfo)
            
            let mirror = Mirror(reflecting: systemInfo.machine)
            machineIdentifier = mirror.children.reduce("") { (identifier, element) in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            
        }
        
        return DeviceInfo(identifier: machineIdentifier)
        
    }
    
    /// Flag indicating whether the current device is a simulator.
    var isSimulator: Bool {
        return (self.info(includeSimulator: true) == .simulator)
    }
    
    /// Flag indicating whether the current device is a phone.
    var isPhone: Bool {
        
        return self.info()
            .displayName
            .contains("iPhone")
        
    }
    
    /// Flag indicating whether the current device is an iPad.
    var isPad: Bool {
        
        return self.info()
            .displayName
            .contains("iPad")
        
    }
    
    /// Flag indicating whether the current device is an iPod.
    var isPod: Bool {
        
        return self.info()
            .displayName
            .contains("iPod")
        
    }
    
    /// Flag indicating whether the current device is a TV.
    var isTV: Bool {
        
        return self.info()
            .displayName
            .contains("TV")
        
    }
    
    /// Flag indicating whether the current device is a modern phone (edge-to-edge screen without a home button).
    var isModernPhone: Bool {
        
        let info = self.info()
        
        return (
            info == .iPhoneX ||
            info == .iPhoneXR ||
            info == .iPhoneXS ||
            info == .iPhoneXSMax ||
            info == .iPhone11 ||
            info == .iPhone11Pro ||
            info == .iPhone11ProMax ||
            info == .iPhone12 ||
            info == .iPhone12Mini ||
            info == .iPhone12Pro ||
            info == .iPhone12ProMax ||
            info == .iPhone13 ||
            info == .iPhone13Mini ||
            info == .iPhone13Pro ||
            info == .iPhone13ProMax
        )
        
    }
    
    /// Flag indicating whether the current device is a modern pad (edge-to-edge screen without a home button).
    var isModernPad: Bool {
        
        let info = self.info()
        
        return (
            info == .iPadPro11 ||
            info == .iPadPro11_2 ||
            info == .iPadPro11_3 ||
            info == .iPadPro12_3 ||
            info == .iPadPro12_4 ||
            info == .iPadPro12_5 ||
            info == .iPadMini_6
        )
        
    }
    
    /// Flag indicating whether the current device is modern (edge-to-edge screen without a home button).
    var isModern: Bool {
        return (self.isModernPhone || self.isModernPad)
    }
    
}
