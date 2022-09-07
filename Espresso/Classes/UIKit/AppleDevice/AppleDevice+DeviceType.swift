//
//  AppleDevice+DeviceType.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/22.
//

import Foundation

public extension AppleDevice /* Device Type */ {
    
    /// Representation of the various Apple device types.
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
        case iPhone14
        case iPhone14Plus
        case iPhone14Pro
        case iPhone14ProMax
                
        case iPodTouch
        case iPodTouch_2
        case iPodTouch_3
        case iPodTouch_4
        case iPodTouch_5
        case iPodTouch_6
        case iPodTouch_7
                
        case iPad
        case iPad2
        case iPad_3
        case iPadMini
        case iPad_4
        case iPadAir
        case iPadMini2
        case iPadMini3
        case iPadMini4
        case iPadAir2
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
        case appleWatchSE_2
        case appleWatchS8
        case appleWatchUltra
        
        case appleTV
        case appleTV_2
        case appleTV_3
        case appleTVHD
        case appleTV4K
        case appleTV4K_2
                
        case airtag
                
        case airpods
        case airpods_2
        case airpods_3
        case airpodsPro
        case airpodsMax
        case airpodsPro_2
        
        case homepod
        case homepodMini
                
        case unknown
        
        internal var info: (family: Family,
                            name: (marketing: String, generational: String),
                            identifiers: [String]) {
            
            var family: Family
            var marketingName: String
            var generationalName: String?
            var identifiers: [String]
                                        
            switch self {
                
            // MARK: iPhone
                
            case .iPhone:
                
                family = .iPhone
                marketingName = "iPhone"
                identifiers = ["iPhone1,1"]
                
            case .iPhone3G:
                
                family = .iPhone
                marketingName = "iPhone 3G"
                identifiers = ["iPhone1,2"]
                
            case .iPhone3GS:
                
                family = .iPhone
                marketingName = "iPhone 3GS"
                identifiers = ["iPhone2,1"]
                
            case .iPhone4:
                
                family = .iPhone
                marketingName = "iPhone 4"
                identifiers = ["iPhone3,1", "iPhone3,2", "iPhone3,3"]
                
            case .iPhone4S:
                
                family = .iPhone
                marketingName = "iPhone 4S"
                identifiers = ["iPhone4,1"]
                
            case .iPhone5:
                
                family = .iPhone
                marketingName = "iPhone 5"
                identifiers = ["iPhone5,1", "iPhone5,2"]
                
            case .iPhone5C:
                
                family = .iPhone
                marketingName = "iPhone 5C"
                identifiers = ["iPhone5,3", "iPhone5,4"]
                
            case .iPhone5S:
                
                family = .iPhone
                marketingName = "iPhone 5S"
                identifiers = ["iPhone6,1", "iPhone6,2"]

            case .iPhone6:
                
                family = .iPhone
                marketingName = "iPhone 6"
                identifiers = ["iPhone7,2"]
                 
            case .iPhone6Plus:
                
                family = .iPhone
                marketingName = "iPhone 6 Plus"
                identifiers = ["iPhone7,1"]
                 
            case .iPhone6S:
                
                family = .iPhone
                marketingName = "iPhone 6S"
                identifiers = ["iPhone8,1"]
                 
            case .iPhone6SPlus:
                
                family = .iPhone
                marketingName = "iPhone 6S Plus"
                identifiers = ["iPhone8,2"]
                
            case .iPhoneSE:
                
                family = .iPhone
                marketingName = "iPhone SE"
                identifiers = ["iPhone8,4"]
                
            case .iPhone7:
                
                family = .iPhone
                marketingName = "iPhone 7"
                identifiers = ["iPhone9,1", "iPhone9,3"]
                
            case .iPhone7Plus:
                
                family = .iPhone
                marketingName = "iPhone 7 Plus"
                identifiers = ["iPhone9,2", "iPhone9,4"]
                
            case .iPhone8:
                
                family = .iPhone
                marketingName = "iPhone 8"
                identifiers = ["iPhone10,1", "iPhone10,4"]
                
            case .iPhone8Plus:
                
                family = .iPhone
                marketingName = "iPhone 8 Plus"
                identifiers = ["iPhone10,2", "iPhone10,5"]
                
            case .iPhoneX:
                
                family = .iPhone
                marketingName = "iPhone X"
                identifiers = ["iPhone10,3", "iPhone10,6"]

            case .iPhoneXR:
                
                family = .iPhone
                marketingName = "iPhone XR"
                identifiers = ["iPhone11,8"]

            case .iPhoneXS:
                
                family = .iPhone
                marketingName = "iPhone XS"
                identifiers = ["iPhone11,2"]

            case .iPhoneXSMax:
                
                family = .iPhone
                marketingName = "iPhone XS Max"
                identifiers = ["iPhone11,4", "iPhone11,6"]
                
            case .iPhone11:
                
                family = .iPhone
                marketingName = "iPhone 11"
                identifiers = ["iPhone12,1"]
                
            case .iPhone11Pro:
                
                family = .iPhone
                marketingName = "iPhone 11 Pro"
                identifiers = ["iPhone12,3"]
                
            case .iPhone11ProMax:
                
                family = .iPhone
                marketingName = "iPhone 11 Pro Max"
                identifiers = ["iPhone12,5"]
                
            case .iPhoneSE_2:
                
                family = .iPhone
                marketingName = "iPhone SE"
                generationalName = "iPhone SE (2nd Gen)"
                identifiers = ["iPhone12,8"]
                
            case .iPhone12:
                
                family = .iPhone
                marketingName = "iPhone 12"
                identifiers = ["iPhone13,2"]
                
            case .iPhone12Mini:
                
                family = .iPhone
                marketingName = "iPhone 12 mini"
                identifiers = ["iPhone13,1"]
                
            case .iPhone12Pro:
                
                family = .iPhone
                marketingName = "iPhone 12 Pro"
                identifiers = ["iPhone13,3"]

            case .iPhone12ProMax:
                
                family = .iPhone
                marketingName = "iPhone 12 Pro Max"
                identifiers = ["iPhone13,4"]

            case .iPhone13:
                
                family = .iPhone
                marketingName = "iPhone 13"
                identifiers = ["iPhone14,5"]

            case .iPhone13Mini:
                
                family = .iPhone
                marketingName = "iPhone 13 mini"
                identifiers = ["iPhone14,4"]

            case .iPhone13Pro:
                
                family = .iPhone
                marketingName = "iPhone 13 Pro"
                identifiers = ["iPhone14,2"]

            case .iPhone13ProMax:
                
                family = .iPhone
                marketingName = "iPhone 13 Pro Max"
                identifiers = ["iPhone14,3"]
                
            case .iPhoneSE_3:
                
                family = .iPhone
                marketingName = "iPhone SE"
                generationalName = "iPhone SE (3rd Gen)"
                identifiers = ["iPhone14,6"]
                
            case .iPhone14:
                
            case .iPhone14Plus:
                
            case .iPhone14Pro:
                
            case .iPhone14ProMax:
                
            // MARK: iPod
                                
            case .iPodTouch:
                
                family = .iPod
                marketingName = "iPod touch"
                identifiers = ["iPod1,1"]
                
            case .iPodTouch_2:
                
                family = .iPod
                marketingName = "iPod touch"
                generationalName = "iPod touch (2nd Gen)"
                identifiers = ["iPod2,1"]
                
            case .iPodTouch_3:
                
                family = .iPod
                marketingName = "iPod touch"
                generationalName = "iPod touch (3rd Gen)"
                identifiers = ["iPod3,1"]
                
            case .iPodTouch_4:
                
                family = .iPod
                marketingName = "iPod touch"
                generationalName = "iPod touch (4th Gen)"
                identifiers = ["iPod4,1"]
                
            case .iPodTouch_5:
                
                family = .iPod
                marketingName = "iPod touch"
                generationalName = "iPod touch (5th Gen)"
                identifiers = ["iPod5,1"]
                
            case .iPodTouch_6:
                
                family = .iPod
                marketingName = "iPod touch"
                generationalName = "iPod touch (6th Gen)"
                identifiers = ["iPod7,1"]
                
            case .iPodTouch_7:
                
                family = .iPod
                marketingName = "iPod touch"
                generationalName = "iPod touch (7th Gen)"
                identifiers = ["iPod9,1"]
                
            // MARK: iPad
                
            case .iPad:
                
                family = .iPad
                marketingName = "iPad"
                identifiers = ["iPad1,1", "iPad1,2"]
                
            case .iPad2:
                
                family = .iPad
                marketingName = "iPad 2"
                identifiers = ["iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4"]
                
            case .iPad_3:
                
                family = .iPad
                marketingName = "iPad"
                generationalName = "iPad (3rd Gen)"
                identifiers = ["iPad3,1", "iPad3,2", "iPad3,3"]
                
            case .iPadMini:
                
                family = .iPad
                marketingName = "iPad mini"
                identifiers = ["iPad2,5", "iPad2,6", "iPad2,7"]
                
            case .iPad_4:
                
                family = .iPad
                marketingName = "iPad"
                generationalName = "iPad (4th Gen)"
                identifiers = ["iPad3,4", "iPad3,5", "iPad3,6"]
                
            case .iPadAir:
                
                family = .iPad
                marketingName = "iPad Air"
                identifiers = ["iPad4,1", "iPad4,2", "iPad4,3"]
                
            case .iPadMini2:
                
                family = .iPad
                marketingName = "iPad mini 2"
                identifiers = ["iPad4,4", "iPad4,5", "iPad4,6"]
                
            case .iPadMini3:
                
                family = .iPad
                marketingName = "iPad mini 3"
                identifiers = ["iPad4,7", "iPad4,8", "iPad4,9"]
                
            case .iPadMini4:
                
                family = .iPad
                marketingName = "iPad mini 4"
                identifiers = ["iPad5,1", "iPad5,2"]
                
            case .iPadAir2:
                
                family = .iPad
                marketingName = "iPad Air 2"
                identifiers = ["iPad5,3", "iPad5,4"]
                
            case .iPadPro9:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (9.7-inch)"
                identifiers = ["iPad6,3", "iPad6,4"]
                
            case .iPadPro12:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (12.9-inch)"
                identifiers = ["iPad6,7", "iPad6,8"]
                
            case .iPad_5:
                
                family = .iPad
                marketingName = "iPad"
                generationalName = "iPad (5th Gen)"
                identifiers = ["iPad6,11", "iPad6,12"]
                
            case .iPadPro12_2:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (12.9-inch) (2nd Gen)"
                identifiers = ["iPad7,1", "iPad7,2"]
                
            case .iPadPro10:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (10.5-inch)"
                identifiers = ["iPad7,3", "iPad7,4"]
                
            case .iPad_6:
                
                family = .iPad
                marketingName = "iPad"
                generationalName = "iPad (6th Gen)"
                identifiers = ["iPad7,5", "iPad7,6"]
                
            case .iPad_7:
                
                family = .iPad
                marketingName = "iPad"
                generationalName = "iPad (7th Gen)"
                identifiers = ["iPad7,11", "iPad7,12"]
                
            case .iPadPro11:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (11-inch)"
                identifiers = ["iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4"]
                
            case .iPadPro12_3:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (12.9-inch) (3rd Gen)"
                identifiers = ["iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8"]
                
            case .iPadPro11_2:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (11-inch) (2nd Gen)"
                identifiers = ["iPad8,9", "iPad8,10"]

            case .iPadPro12_4:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName =  "iPad Pro (12.9-inch) (4th Gen)"
                identifiers = ["iPad8,11", "iPad8,12"]

            case .iPadMini_5:
                
                family = .iPad
                marketingName = "iPad mini"
                generationalName = "iPad mini (5th Gen)"
                identifiers = ["iPad11,1", "iPad11,2"]
                
            case .iPadAir_3:
                
                family = .iPad
                marketingName = "iPad Air"
                generationalName = "iPad Air (3rd Gen)"
                identifiers = ["iPad11,3", "iPad11,4"]

            case .iPad_8:
                
                family = .iPad
                marketingName = "iPad"
                generationalName = "iPad (8th Gen)"
                identifiers = ["iPad11,6", "iPad11,7"]
                
            case .iPadAir_4:
                
                family = .iPad
                marketingName = "iPad Air"
                generationalName = "iPad Air (4th Gen)"
                identifiers = ["iPad13,1", "iPad13,2"]
                
            case .iPadPro11_3:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (11-inch) (3rd Gen)"
                identifiers = ["iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7"]
                
            case .iPadPro12_5:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (12.9-inch) (5th Gen)"
                identifiers = ["iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11"]
                
            case .iPad_9:
                
                family = .iPad
                marketingName = "iPad"
                generationalName = "iPad (9th Gen)"
                identifiers = ["iPad12,1", "iPad12,2"]
                
            case .iPadMini_6:
                
                family = .iPad
                marketingName = "iPad mini"
                generationalName = "iPad mini (6th Gen)"
                identifiers = ["iPad14,1", "iPad14,2"]
                
            case .iPadAir_5:
                
                family = .iPad
                marketingName = "iPad Air"
                generationalName = "iPad Air (5th Gen)"
                identifiers = ["iPad13,6", "iPad13,7"]
                
            // MARK: Apple Watch
                
            case .appleWatch:
                
                family = .appleWatch
                marketingName = "Apple Watch"
                identifiers = ["Watch1,1", "Watch1,2"]
                
            case .appleWatchS1:
                
                family = .appleWatch
                marketingName = "Apple Watch Series 1"
                identifiers = ["Watch2,6", "Watch2,7"]
                
            case .appleWatchS2:
                
                family = .appleWatch
                marketingName = "Apple Watch Series 2"
                identifiers = ["Watch2,3", "Watch2,4"]
                
            case .appleWatchS3:
                
                family = .appleWatch
                marketingName = "Apple Watch Series 3"
                identifiers = ["Watch3,1", "Watch3,2", "Watch3,3", "Watch3,4"]
                
            case .appleWatchS4:
                
                family = .appleWatch
                marketingName = "Apple Watch Series 4"
                identifiers = ["Watch4,1", "Watch4,2", "Watch4,3", "Watch4,4"]
                
            case .appleWatchS5:
                
                family = .appleWatch
                marketingName = "Apple Watch Series 5"
                identifiers = ["Watch5,1", "Watch5,2", "Watch5,3", "Watch5,4"]
                
            case .appleWatchSE:
                
                family = .appleWatch
                marketingName = "Apple Watch SE"
                identifiers = ["Watch5,9", "Watch5,10", "Watch5,11", "Watch5,12"]
                
            case .appleWatchS6:
                
                family = .appleWatch
                marketingName = "Apple Watch Series 6"
                identifiers = ["Watch6,1", "Watch6,2", "Watch6,3", "Watch6,4"]
                
            case .appleWatchS7:
                
                family = .appleWatch
                marketingName = "Apple Watch Series 7"
                identifiers = ["Watch6,6", "Watch6,7", "Watch6,8", "Watch6,9"]
                
            case .appleWatchSE_2:
                
            case .appleWatchS8:
                
            case .appleWatchUltra:
                
            // MARK: Apple TV
                 
            case .appleTV:
                
                family = .appleTV
                marketingName = "Apple TV"
                identifiers = ["AppleTV1,1"]
                
            case .appleTV_2:
                
                family = .appleTV
                marketingName = "Apple TV"
                generationalName = "Apple TV (2nd Gen)"
                identifiers = ["AppleTV2,1"]

            case .appleTV_3:
                
                family = .appleTV
                marketingName = "Apple TV"
                generationalName = "Apple TV (3nd Gen)"
                identifiers = ["AppleTV3,1", "AppleTV3,2"]
                
            case .appleTVHD:
                
                family = .appleTV
                marketingName = "Apple TV HD"
                identifiers = ["AppleTV5,3"]
                
            case .appleTV4K:
                
                family = .appleTV
                marketingName = "Apple TV 4K"
                identifiers = ["AppleTV6,2"]
                
            case .appleTV4K_2:
                
                family = .appleTV
                marketingName = "Apple TV 4K"
                generationalName = "Apple TV 4K (2nd Gen)"
                identifiers = ["AppleTV11,1"]
                  
            // MARK: AirTag
                
            case .airtag:
                
                family = .airTag
                marketingName = "AirTag"
                identifiers = ["AirTag1,1"]
                  
            // MARK: AirPods
                
            case .airpods:
                
                family = .airPods
                marketingName = "AirPods"
                identifiers = ["AirPods1,1"]
                
            case .airpods_2:
                
                family = .airPods
                marketingName = "AirPods"
                generationalName = "AirPods (2nd Gen)"
                identifiers = ["AirPods1,2", "AirPods2,1"]
                
            case .airpods_3:
                
                family = .airPods
                marketingName = "AirPods"
                generationalName = "AirPods (3rd Gen)"
                identifiers = ["AirPods1,3", "Audio2,1"]
                
            case .airpodsPro:
                
                family = .airPods
                marketingName = "AirPods Pro"
                identifiers = ["iProd8,1", "AirPods2,2", "AirPodsPro1,1"]
                
            case .airpodsMax:
                
                family = .airPods
                marketingName = "AirPods Max"
                identifiers = ["iProd8,6", "AirPodsMax1,1"]
                
            case .airpodsPro_2:
                
            // MARK: HomePod

            case .homepod:
                
                family = .homePod
                marketingName = "HomePod"
                identifiers = ["AudioAccessory1,1", "AudioAccessory1,2"]
                
            case .homepodMini:
                
                family = .homePod
                marketingName = "HomePod mini"
                identifiers = ["AudioAccessory5,1"]
                
            // MARK: Other
                
            case .unknown:
                
                family = .unknown
                marketingName = "Unknown"
                identifiers = ["unknown"]
                
            }
            
            return (
                family,
                (marketingName, generationalName ?? marketingName),
                identifiers
            )
            
        }
        
    }
    
}
