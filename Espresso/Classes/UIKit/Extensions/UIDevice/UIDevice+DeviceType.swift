//
//  UIDevice+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

public extension UIDevice /* Info */ {
    
    /// Representation of the various device types.
    enum DeviceType: String, CaseIterable {
                
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
                
        case iPodTouch
        case iPodTouch_2
        case iPodTouch_3
        case iPodTouch_4
        case iPodTouch_5
        case iPodTouch_6
        case iPodTouch_7
                
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
        
        case appleWatch
        case appleWatchS1
        case appleWatchS2
        case appleWatchS3
        case appleWatchS4
        case appleWatchS5
        case appleWatchSE
        case appleWatchS6
        case appleWatchS7
                
        case appleTV
        case appleTV_2
        case appleTV_3
        case appleTV_4
        case appleTV4K
        case appleTV4K_2
                
        case airtag
                
        case airpods
        case airpods_2
        case airpodsPro
        case airpodsMax
                
        case homepod
        case homepodMini
                
        case simulator
        case unknown
        
        internal var info: (name: String,
                            identifiers: [String]) {
            
            var name: String
            var identifiers = [String]()
                                        
            switch self {
                
            // MARK: iPhone
                
            case .iPhone:
                
                name = "iPhone"
                identifiers = ["iPhone1,1"]
                
            case .iPhone3G:
                
                name = "iPhone 3G"
                identifiers = ["iPhone1,2"]
                
            case .iPhone3GS:
                
                name = "iPhone 3GS"
                identifiers = ["iPhone2,1"]
                
            case .iPhone4:
                
                name = "iPhone 4"
                identifiers = ["iPhone3,1", "iPhone3,2", "iPhone3,3"]
                
            case .iPhone4S:
                
                name = "iPhone 4S"
                identifiers = ["iPhone4,1"]
                
            case .iPhone5:
                
                name = "iPhone 5"
                identifiers = ["iPhone5,1", "iPhone5,2"]
                
            case .iPhone5C:
                
                name = "iPhone 5c"
                identifiers = ["iPhone5,3", "iPhone5,4"]
                
            case .iPhone5S:
                
                name = "iPhone 5s"
                identifiers = ["iPhone6,1", "iPhone6,2"]
                
            case .iPhone6:
                
                name = "iPhone 6"
                identifiers = ["iPhone7,2"]
                
            case .iPhone6Plus:
                
                name = "iPhone 6 Plus"
                identifiers = ["iPhone7,1"]
                
            case .iPhone6S:
                
                name = "iPhone 6s"
                identifiers = ["iPhone8,1"]
                
            case .iPhone6SPlus:
                
                name = "iPhone 6s Plus"
                identifiers = ["iPhone8,2"]
                
            case .iPhoneSE:
                
                name = "iPhone SE"
                identifiers = ["iPhone8,4"]
                
            case .iPhone7:
                
                name = "iPhone 7"
                identifiers = ["iPhone9,1", "iPhone9,3"]
                
            case .iPhone7Plus:
                
                name = "iPhone 7 Plus"
                identifiers = ["iPhone9,2", "iPhone9,4"]
                
            case .iPhone8:
                
                name = "iPhone 8"
                identifiers = ["iPhone10,1", "iPhone10,4"]
                
            case .iPhone8Plus:
                
                name = "iPhone 8 Plus"
                identifiers = ["iPhone10,2", "iPhone10,5"]
                
            case .iPhoneX:
                
                name = "iPhone X"
                identifiers = ["iPhone10,3", "iPhone10,6"]
                
            case .iPhoneXR:
                
                name = "iPhone XR"
                identifiers = ["iPhone11,8"]
                
            case .iPhoneXS:
                
                name = "iPhone XS"
                identifiers = ["iPhone11,2"]
                
            case .iPhoneXSMax:
                
                name = "iPhone XS Max"
                identifiers = ["iPhone11,4", "iPhone11,6"]
                
            case .iPhone11:
                
                name = "iPhone 11"
                identifiers = ["iPhone12,1"]
                
            case .iPhone11Pro:
                
                name = "iPhone 11 Pro"
                identifiers = ["iPhone12,3"]
                
            case .iPhone11ProMax:
                
                name = "iPhone 11 Pro Max"
                identifiers = ["iPhone12,5"]
                
            case .iPhoneSE_2:
                
                name = "iPhone SE (2nd Gen)"
                identifiers = ["iPhone12,8"]
                
            case .iPhone12:
                
                name = "iPhone 12"
                identifiers = ["iPhone13,2"]
                
            case .iPhone12Mini:
                
                name = "iPhone 12 mini"
                identifiers = ["iPhone13,1"]
                
            case .iPhone12Pro:
                
                name = "iPhone 12 Pro"
                identifiers = ["iPhone13,3"]
                
            case .iPhone12ProMax:
                
                name = "iPhone 12 Pro Max"
                identifiers = ["iPhone13,4"]
                
            case .iPhone13:
                
                name = "iPhone 13"
                identifiers = ["iPhone14,5"]
                
            case .iPhone13Mini:
                
                name = "iPhone 13 mini"
                identifiers = ["iPhone14,4"]
                
            case .iPhone13Pro:
                
                name = "iPhone 13 Pro"
                identifiers = ["iPhone14,2"]
                
            case .iPhone13ProMax:
                
                name = "iPhone 13 Pro Max"
                identifiers = ["iPhone14,3"]
                
            case .iPhoneSE_3:
                
                name = "iPhone SE (3rd Gen)"
                identifiers = ["iPhone14,6"]
                
            // MARK: iPod
                                
            case .iPodTouch:
                
                name = "iPod touch"
                identifiers = ["iPod1,1"]
                
            case .iPodTouch_2:
                
                name = "iPod touch (2nd Gen)"
                identifiers = ["iPod2,1"]
                
            case .iPodTouch_3:
                
                name = "iPod touch (3rd Gen)"
                identifiers = ["iPod3,1"]
                
            case .iPodTouch_4:
                
                name = "iPod touch (4th Gen)"
                identifiers = ["iPod4,1"]
                
            case .iPodTouch_5:
                
                name = "iPod touch (5th Gen)"
                identifiers = ["iPod5,1"]
                
            case .iPodTouch_6:
                
                name = "iPod touch (6th Gen)"
                identifiers = ["iPod7,1"]
                
            case .iPodTouch_7:
                
                name = "iPod touch (7th Gen)"
                identifiers = ["iPod9,1"]
                
            // MARK: iPad
                
            case .iPad:
                
                name = "iPad"
                identifiers = ["iPad1,1"]
                
            case .iPad3G:
                
                name = "iPad 3G"
                identifiers = ["iPad1,2"]
                
            case .iPad_2:
                
                name = "iPad (2nd Gen)"
                identifiers = ["iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4"]
                
            case .iPad_3:
                
                name = "iPad (3rd Gen)"
                identifiers = ["iPad3,1", "iPad3,2", "iPad3,3"]
                
            case .iPadMini:
                
                name = "iPad mini"
                identifiers = ["iPad2,5", "iPad2,6", "iPad2,7"]
                
            case .iPad_4:
                
                name = "iPad (4th Gen)"
                identifiers = ["iPad3,4", "iPad3,5", "iPad3,6"]
                
            case .iPadAir:
                
                name = "iPad Air"
                identifiers = ["iPad4,1", "iPad4,2", "iPad4,3"]
                
            case .iPadMini_2:
                
                name = "iPad mini (2nd Gen)"
                identifiers = ["iPad4,4", "iPad4,5", "iPad4,6"]
                
            case .iPadMini_3:
                
                name = "iPad mini (3rd Gen)"
                identifiers = ["iPad4,7", "iPad4,8", "iPad4,9"]
                
            case .iPadMini_4:
                
                name = "iPad mini (4th Gen)"
                identifiers = ["iPad5,1", "iPad5,2"]
                
            case .iPadAir_2:
                
                name = "iPad Air (2nd Gen)"
                identifiers = ["iPad5,3", "iPad5,4"]
                
            case .iPadPro9:
                
                name = "iPad Pro (9-inch)"
                identifiers = ["iPad6,3", "iPad6,4"]
                
            case .iPadPro12:
                
                name = "iPad Pro (12.9-inch)"
                identifiers = ["iPad6,7", "iPad6,8"]
                
            case .iPad_5:
                
                name = "iPad (5th Gen)"
                identifiers = ["iPad6,11", "iPad6,12"]
                
            case .iPadPro12_2:
                
                name = "iPad Pro (12.9-inch) (2nd Gen)"
                identifiers = ["iPad7,1", "iPad7,2"]
                
            case .iPadPro10:
                
                name = "iPad Pro (10.5-inch)"
                identifiers = ["iPad7,3", "iPad7,4"]
                
            case .iPad_6:
                
                name = "iPad (6th Gen)"
                identifiers = ["iPad7,5", "iPad7,6"]
                
            case .iPad_7:
                
                name = "iPad (7th Gen)"
                identifiers = ["iPad7,11", "iPad7,12"]
                
            case .iPadPro11:
                
                name = "iPad Pro (11-inch)"
                identifiers = ["iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4"]
                
            case .iPadPro12_3:
                
                name = "iPad Pro (12.9-inch) (3rd Gen)"
                identifiers = ["iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8"]
                
            case .iPadPro11_2:
                
                name = "iPad Pro (11-inch) (2nd Gen)"
                identifiers = ["iPad8,9", "iPad8,10"]
                
            case .iPadPro12_4:
                
                name =  "iPad Pro (12.9-inch) (4th Gen)"
                identifiers = ["iPad8,11", "iPad8,12"]
                
            case .iPadMini_5:
                
                name = "iPad mini (5th Gen)"
                identifiers = ["iPad11,1", "iPad11,2"]
                
            case .iPadAir_3:
                
                name = "iPad Air (3rd Gen)"
                identifiers = ["iPad11,3", "iPad11,4"]
                
            case .iPad_8:
                
                name = "iPad (8th Gen)"
                identifiers = ["iPad11,6", "iPad11,7"]
                
            case .iPadAir_4:
                
                name = "iPad Air (4th Gen)"
                identifiers = ["iPad13,1", "iPad13,2"]
                
            case .iPadPro11_3:
                
                name = "iPad Pro (11-inch) (3rd Gen)"
                identifiers = ["iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7"]
                
            case .iPadPro12_5:
                
                name = "iPad Pro (12.9-inch) (5th Gen)"
                identifiers = ["iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11"]
                
            case .iPad_9:
                
                name = "iPad (9th Gen)"
                identifiers = ["iPad12,1", "iPad12,2"]
                
            case .iPadMini_6:
                
                name = "iPad mini (6th Gen)"
                identifiers = ["iPad14,1", "iPad14,2"]
                
            case .iPadAir_5:
                
                name = "iPad Air (5th Gen)"
                identifiers = ["iPad13,6", "iPad13,7"]
                
            // MARK: Apple Watch
                
            case .appleWatch:
                
                name = "Apple Watch"
                identifiers = ["Watch1,1", "Watch1,2"]
                
            case .appleWatchS1:
                
                name = "Apple Watch Series 1"
                identifiers = ["Watch2,6", "Watch2,7"]
                
            case .appleWatchS2:
                
                name = "Apple Watch Series 2"
                identifiers = ["Watch2,3", "Watch2,4"]
                
            case .appleWatchS3:
                
                name = "Apple Watch Series 3"
                identifiers = ["Watch3,1", "Watch3,2", "Watch3,3", "Watch3,4"]
                
            case .appleWatchS4:
                
                name = "Apple Watch Series 4"
                identifiers = ["Watch4,1", "Watch4,2", "Watch4,3", "Watch4,4"]
                
            case .appleWatchS5:
                
                name = "Apple Watch Series 5"
                identifiers = ["Watch5,1", "Watch5,2", "Watch5,3", "Watch5,4"]
                
            case .appleWatchSE:
                
                name = "Apple Watch SE"
                identifiers = ["Watch5,9", "Watch5,10", "Watch5,11", "Watch5,12"]
                
            case .appleWatchS6:
                
                name = "Apple Watch Series 6"
                identifiers = ["Watch6,1", "Watch6,2", "Watch6,3", "Watch6,4"]
                
            case .appleWatchS7:
                
                name = "Apple Watch Series 7"
                identifiers = ["Watch6,6", "Watch6,7", "Watch6,8", "Watch6,9"]
                
            // MARK: Apple TV
                 
            case .appleTV:
                
                name = "Apple TV"
                identifiers = ["AppleTV1,1"]
                
            case .appleTV_2:
                
                name = "Apple TV (2nd Gen)"
                identifiers = ["AppleTV2,1"]
                
            case .appleTV_3:
                
                name = "Apple TV (3nd Gen)"
                identifiers = ["AppleTV3,1", "AppleTV3,2"]
                
            case .appleTV_4:
                
                name = "Apple TV (4nd Gen)"
                identifiers = ["AppleTV5,3"]
                
            case .appleTV4K:
                
                name = "Apple TV 4K"
                identifiers = ["AppleTV6,2"]
                
            case .appleTV4K_2:
                
                name = "Apple TV 4K (2nd Gen)"
                identifiers = ["AppleTV11,1"]
                       
            // MARK: AirTag
                
            case .airtag:
                
                name = "AirTag"
                identifiers = ["AirTag1,1"]
                    
            // MARK: AirPods
                
            case .airpods:
                
                name = "AirPods"
                identifiers = ["AirPods1,1"]
                
            case .airpods_2:
                
                name = "AirPods (2nd Gen)"
                identifiers = ["AirPods2,1"]
                
            case .airpodsPro:
                
                name = "AirPods Pro"
                identifiers = ["AirPods2,2", "iProd8,1"]
                
            case .airpodsMax:
                
                name = "AirPods Max"
                identifiers = ["iProd8,6"]
                
            // MARK: HomePod

            case .homepod:
                
                name = "HomePod"
                identifiers = ["AudioAccessory1,1", "AudioAccessory1,2"]
                
            case .homepodMini:
                
                name = "HomePod mini"
                identifiers = ["AudioAccessory5,1"]
                
            // MARK: Other

            case .simulator:
                
                name = "Simulator"
                identifiers = ["i386", "x86_64", "arm64"]
                
            case .unknown:
                
                name = "Unknown"
                identifiers = []
                
            }
            
            return (name, identifiers)
            
        }
        
        /// The device's display name.
        public var displayName: String {
            return self.info.name
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
            
            // 1 - check for common jailbroken files
            
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
            
            // 2 - check for sandbox violation
            
            do {
                try "jailbroken".write(toFile: "/private/jailbroken.txt", atomically: true, encoding: .utf8)
                return true
            }
            catch {
                return false
            }
            
        }
        
        internal init(identifier: String) {
            
            for type in DeviceType.allCases {
                
                for id in type.info.identifiers {
                    
                    guard identifier == id else { continue }
                    self = type
                    return
                    
                }
                
            }
            
            self = .unknown
            
        }
        
    }
    
}
