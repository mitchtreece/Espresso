//
//  UIDevice+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

public extension UIDevice /* Info*/ {
    
    /// Representation of the various iOS device types.
    /// Also provides information about the current device's system & state.
    enum DeviceInfo: String, CaseIterable {
        
        // iPhone
        
        case iPhone2G
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
        case iPhoneSE_2G
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
        case iPhone12
        case iPhone12Mini
        case iPhone12Pro
        case iPhone12ProMax
        
        // iPod Touch
        
        case iPodTouch
        case iPodTouch2G
        case iPodTouch3G
        case iPodTouch4G
        case iPodTouch5G
        case iPodTouch6G
        case iPodTouch7G
        
        // iPad
        
        case iPad
        case iPad2
        case iPad3G
        case iPad4G
        case iPad5G
        case iPad6G
        case iPad7G
        case iPad8G
        case iPadMini
        case iPadMini2
        case iPadMini3
        case iPadMini4
        case iPadMini5G
        case iPadAir
        case iPadAir2
        case iPadAir3G
        case iPadAir4G
        case iPadPro9
        case iPadPro10
        case iPadPro12
        case iPadPro12_2G
        case iPadPro11
        case iPadPro12_3G
        case iPadPro11_2G
        case iPadPro12_4G
        
        // Watch
        
        case appleWatch
        case appleWatchS1
        case appleWatchS2
        case appleWatchS3
        case appleWatchS4
        case appleWatchS5
        case appleWatchS6
        case appleWatchSE
        
        // Apple TV
        
        case appleTV
        case appleTV4K
        
        // HomePod
        
        case homepod
        case homepodMini
        
        // Other
        
        case simulator
        case unknown
        
        /// The device's display name.
        public var displayName: String {
            
            switch self {
            case .iPhone2G: return "iPhone 2G"
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
            case .iPhoneSE_2G: return "iPhone SE 2G"
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
            case .iPhone12: return "iPhone 12"
            case .iPhone12Mini: return "iPhone 12 mini"
            case .iPhone12Pro: return "iPhone 12 Pro"
            case .iPhone12ProMax: return "iPhone 12 Pro Max"
            
            case .iPodTouch: return "iPod touch"
            case .iPodTouch2G: return "iPod touch 2G"
            case .iPodTouch3G: return "iPod touch 3G"
            case .iPodTouch4G: return "iPod touch 4G"
            case .iPodTouch5G: return "iPod touch 5G"
            case .iPodTouch6G: return "iPod touch 6G"
            case .iPodTouch7G: return "iPod touch 7G"
                
            case .appleWatch: return "Apple Watch"
            case .appleWatchS1: return "Apple Watch Series 1"
            case .appleWatchS2: return "Apple Watch Series 2"
            case .appleWatchS3: return "Apple Watch Series 3"
            case .appleWatchS4: return "Apple Watch Series 4"
            case .appleWatchS5: return "Apple Watch Series 5"
            case .appleWatchS6: return "Apple Watch Series 6"
            case .appleWatchSE: return "Apple Watch SE"
                
            case .iPad: return "iPad"
            case .iPad2: return "iPad 2"
            case .iPad3G: return "iPad 3G"
            case .iPad4G: return "iPad 4G"
            case .iPad5G: return "iPad 5G"
            case .iPad6G: return "iPad 6G"
            case .iPad7G: return "iPad 7G"
            case .iPad8G: return "iPad 8G"
            case .iPadMini: return "iPad mini"
            case .iPadMini2: return "iPad mini 2"
            case .iPadMini3: return "iPad mini 3"
            case .iPadMini4: return "iPad mini 4"
            case .iPadMini5G: return "iPad mini 5G"
            case .iPadAir: return "iPad Air"
            case .iPadAir2: return "iPad Air 2"
            case .iPadAir3G: return "iPad Air 3G"
            case .iPadAir4G: return "iPad Air 4G"
            case .iPadPro9: return "iPad Pro (9-inch)"
            case .iPadPro10: return "iPad Pro (10.5-inch)"
            case .iPadPro12: return "iPad Pro (12.9-inch)"
            case .iPadPro12_2G: return "iPad Pro (12.9-inch) 2G"
            case .iPadPro11: return "iPad Pro (11-inch)"
            case .iPadPro12_3G: return "iPad Pro (12.9-inch) 3G"
            case .iPadPro11_2G: return "iPad Pro (11-inch) 2G"
            case .iPadPro12_4G: return "iPad Pro (12.9-inch) 4G"
                
            case .appleTV: return "Apple TV"
            case .appleTV4K: return "Apple TV 4K"
                
            case .homepod: return "HomePod"
            case .homepodMini: return "HomePod mini"
                
            case .simulator: return "Simulator"
            case .unknown: return "Unknown"
            }
            
        }
        
        internal var identifiers: [String] {
            
            switch self {
            case .iPhone2G: return ["iPhone1,1"]
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
            case .iPhoneSE_2G: return ["iPhone12,8"]
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
            case .iPhone12: return ["iPhone13,2"]
            case .iPhone12Mini: return ["iPhone13,1"]
            case .iPhone12Pro: return ["iPhone13,3"]
            case .iPhone12ProMax: return ["iPhone13,4"]
                
            case .iPodTouch: return ["iPod1,1"]
            case .iPodTouch2G: return ["iPod2,1"]
            case .iPodTouch3G: return ["iPod3,1"]
            case .iPodTouch4G: return ["iPod4,1"]
            case .iPodTouch5G: return ["iPod5,1"]
            case .iPodTouch6G: return ["iPod7,1"]
            case .iPodTouch7G: return ["iPod9,1"]
                
            case .iPad: return ["iPad1,1", "iPad1,2"]
            case .iPad2: return ["iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4"]
            case .iPad3G: return ["iPad3,1", "iPad3,2", "iPad3,3"]
            case .iPad4G: return ["iPad3,4", "iPad3,5", "iPad3,6"]
            case .iPad5G: return ["iPad6,11", "iPad6,12"]
            case .iPad6G: return ["iPad7,5", "iPad7,6"]
            case .iPad7G: return ["iPad7,11", "iPad7,12"]
            case .iPad8G: return ["iPad11,6", "iPad11,7"]
            case .iPadMini: return ["iPad2,5", "iPad2,6", "iPad2,7"]
            case .iPadMini2: return ["iPad4,4", "iPad4,5", "iPad4,6"]
            case .iPadMini3: return ["iPad4,7", "iPad4,8", "iPad4,9"]
            case .iPadMini4: return ["iPad5,1", "iPad5,2"]
            case .iPadMini5G: return ["iPad11,1", "iPad11,2"]
            case .iPadAir: return ["iPad4,1", "iPad4,2", "iPad4,3"]
            case .iPadAir2: return ["iPad5,3", "iPad5,4"]
            case .iPadAir3G: return ["iPad11,3", "iPad11,4"]
            case .iPadAir4G: return ["iPad13,1", "iPad13,2"]
            case .iPadPro9: return ["iPad6,3", "iPad6,4"]
            case .iPadPro10: return ["iPad7,3", "iPad7,4"]
            case .iPadPro12: return ["iPad6,7", "iPad6,8"]
            case .iPadPro12_2G: return ["iPad7,1", "iPad7,2"]
            case .iPadPro11: return ["iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4"]
            case .iPadPro12_3G: return ["iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8"]
            case .iPadPro11_2G: return ["iPad8,9", "iPad8,10"]
            case .iPadPro12_4G: return ["iPad8,11", "iPad8,12"]
                
            case .appleWatch: return ["Watch1,1", "Watch1,2"]
            case .appleWatchS1: return ["Watch2,6", "Watch2,7"]
            case .appleWatchS2: return ["Watch2,3", "Watch2,4"]
            case .appleWatchS3: return ["Watch3,1", "Watch3,2", "Watch3,3", "Watch3,4"]
            case .appleWatchS4: return ["Watch4,1", "Watch4,2", "Watch4,3", "Watch4,4"]
            case .appleWatchS5: return ["Watch5,1", "Watch5,2", "Watch5,3", "Watch5,4"]
            case .appleWatchS6: return ["Watch6,1", "Watch6,2", "Watch6,3", "Watch6,4"]
            case .appleWatchSE: return ["Watch5,9", "Watch5,10", "Watch5,11", "Watch5,12"]
                
            case .appleTV: return ["AppleTV5,3"]
            case .appleTV4K: return ["AppleTV6,2"]
                
            case .homepod: return ["AudioAccessory1,1", "AudioAccessory1,2"]
            case .homepodMini: return ["AudioAccessory5,1"]
            
            case .simulator: return ["i386", "x86_64"]
            case .unknown: return []
            }
            
        }
        
        /// The device's system version string.
        public var systemVersion: String {
            return UIDevice.current.systemVersion
        }
        
        /// Flag indicating whether the current device is jailbroken or not.
        /// This is **not** guaranteed to be 100% accurate.
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
        return (self.info(includeSimulator: true) == DeviceInfo.simulator)
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
            info == .iPhone12ProMax
        )
        
    }
    
    /// Flag indicating whether the current device is a modern pad (edge-to-edge screen without a home button).
    var isModernPad: Bool {
        
        let info = self.info()
        
        return (
            info == .iPadPro11 ||
            info == .iPadPro12_3G ||
            info == .iPadPro11_2G ||
            info == .iPadPro12_4G
        )
        
    }
    
    /// Flag indicating whether the current device is modern (edge-to-edge screen without a home button).
    var isModern: Bool {
        return (self.isModernPhone || self.isModernPad)
    }
    
}
