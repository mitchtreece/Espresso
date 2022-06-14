//
//  DeviceType.swift
//  Espresso
//
//  Created by Mitch Treece on 6/13/22.
//

import UIKit

/// Representation of an Apple hardware device.
public class AppleDevice {
    
    internal static let simulatorPrefix = "__sim_"
    
    /// Representation of the various Apple device model families.
    public enum Family: String, CaseIterable {
        
        case iPhone
        case iPod
        case iPad
        case appleWatch = "Apple Watch"
        case appleTV = "Apple TV"
        case airTag = "AirTag"
        case airPods = "AirPods"
        case homePod = "HomePod"
        case unknown = "Unknown"

    }

    /// Representation of software that runs on an Apple device.
    public struct Software {
        
        /// Representation of the various Apple device software types.
        public enum SoftwareType: String {
            
            /// An iOS software type.
            case iOS
            
            /// An iPadOS software type.
            case iPadOS
            
            /// A watchOS software type.
            case watchOS
            
            /// A tvOS software type.
            case tvOS
            
            /// An audioOS software type.
            case audioOS
            
            /// A generic firmware software type.
            case firmware = "Firmware"
            
        }
        
        /// The software's type.
        public let type: SoftwareType
        
        /// The software's minimum (release) version-string.
        public let minVersionString: String
        
        /// The software's minimum (release) version.
        ///
        /// Certain software versions use non-standard (non-semantic)
        /// formats. In these cases, `minVersion` will be invalid ("0.0.0").
        /// To access the raw non-standard version-string, use `minVersionString` instead.
        public var minVersion: Version {
            return (try? Version(self.minVersionString)) ?? .invalid
        }
        
        /// The software's maximum (end-of-life) version-string.
        public let maxVersionString: String?
        
        /// The software's maximum (end-of-life) version.
        ///
        /// Certain software versions use non-standard (non-semantic)
        /// formats. In these cases, `maxVersion` will be invalid ("0.0.0").
        /// To access the raw non-standard version-string, use `maxVersionString` instead.
        public var maxVersion: Version? {
            
            guard let string = self.maxVersionString else { return nil }
            return (try? Version(string)) ?? .invalid
            
        }
        
        /// The software's first unsupported version-string.
        ///
        /// This is typically the version following the software's `maxVersion`.
        ///
        /// Certain software versions use non-standard (non-semantic)
        /// formats. In these cases, `unsupportedVersion` will be invalid ("0.0.0").
        /// To access the raw non-standard version-string, use `unsupportedVersion` instead.
        public let unsupportedVersionString: String?
        
        /// The software's first unsupported version.
        ///
        /// This is typically the version following the software's `maxVersion`.
        public var unsupportedVersion: Version? {
            
            guard let string = self.unsupportedVersionString else { return nil }
            return (try? Version(string)) ?? .invalid
            
        }
        
        /// The software's name.
        public var name: String {
            
            switch self.type {
            case .iOS: return (self.minVersion >= "4") ? "iOS" : "iPhone OS"
            case .iPadOS: return (self.minVersion >= "13.1") ? "iPadOS" : "iOS"
            case .tvOS: return (self.minVersion >= "9") ? "tvOS" : "Apple TV Software"
            default: return self.type.rawValue
            }
                        
        }
        
        internal init(type: SoftwareType,
                      minVersion: String,
                      maxVersion: String? = nil,
                      unsupportedVersion: String? = nil) {
            
            self.type = type
            self.minVersionString = minVersion
            self.maxVersionString = maxVersion
            self.unsupportedVersionString = unsupportedVersion
            
        }
        
    }
    
    /// The device's identifier.
    ///
    /// i.e. "iPhone1,1", "iPhone10,3", "iPhone14,3"
    public let identifier: String
    
    /// The device's type.
    public private(set) var type: DeviceType = .unknown
    
    internal private(set) var _isSimulator: Bool = false

    /// The device's family.
    public var family: Family {
        return self.type.info.family
    }
    
    /// The device's marketing name.
    ///
    /// This is a generation-independent, (sometimes) shared name.
    ///
    /// ```
    ///   "iPad"    "iPad", "iPad (2nd Gen)", "iPad (4th Gen)"
    /// [Marketing] [------------- Generational -------------]
    /// ```
    public var marketingName: String {
        return self.type.info.name.marketing
    }
    
    /// The device's generational name.
    ///
    /// This is a generation-dependent, unique name.
    ///
    /// ```
    /// "iPad", "iPad (2nd Gen)", "iPad (4th Gen)"   "iPad"
    /// [------------- Generational -------------] [Marketing]
    /// ```
    public var generationalName: String {
        return self.type.info.name.generation
    }
    
    /// The device's system software information.
    public var software: Software {
        return self.type.info.software
    }
    
    /// The device's sibling devices.
    public var siblings: [AppleDevice] {
        
        var siblingIdentifiers = self.type.info.identifiers
        
        siblingIdentifiers
            .removeAll(where: { $0 == self.identifier })
        
        return siblingIdentifiers
            .map { AppleDevice(identifier: $0) }
        
    }
    
    /// Gets the current Apple device.
    /// - returns: An Apple device.
    public static func current() -> LocalAppleDevice {
        
        let identifier = UIDevice
            .current
            .modelIdentifier(simulatorPrefix: true)
        
        return LocalAppleDevice(
            identifier: identifier,
            uiDevice: UIDevice.current
        )
        
    }
    
    /// Initializes an AppleDevice with an identifier.
    /// - parameter identifier: An Apple device identifier. i.e. "iPhone1,1".
    ///
    /// If the provided identifier is unrecognized, the device with an `unknown` device type.
    public init(identifier: String) {
        
        var cleanIdentifier = identifier
        
        if cleanIdentifier.hasPrefix(Self.simulatorPrefix) {
            
            self._isSimulator = true
            
            cleanIdentifier = identifier.replacingOccurrences(
                of: Self.simulatorPrefix,
                with: ""
            )
            
        }
        
        self.identifier = cleanIdentifier
        
        for deviceType in DeviceType.allCases {
            
            for deviceId in deviceType.info.identifiers {
                
                guard deviceId == cleanIdentifier else { continue }
                self.type = deviceType
                return
                
            }
            
        }
        
    }
    
    /// Initializes an AppleDevice with a device type.
    /// - parameter type: An Apple device type.
    ///
    /// When initializing an Apple device from a device type,
    /// the first identifier for that type will be used.
    public init(type: DeviceType) {
        
        self.type = type
        self.identifier = type.info.identifiers.first!
        
    }
    
}

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
                
        case homepod
        case homepodMini
                
        case unknown
        
        internal var info: (family: Family,
                            name: (marketing: String, generation: String),
                            identifiers: [String],
                            software: Software) {
            
            var family: Family
            var marketingName: String
            var generationalName: String?
            var identifiers: [String]
            var software: Software
                                        
            switch self {
                
            // MARK: iPhone
                
            case .iPhone:
                
                family = .iPhone
                marketingName = "iPhone"
                identifiers = ["iPhone1,1"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "1",
                    maxVersion: "3.1.3",
                    unsupportedVersion: "3.2"
                )

            case .iPhone3G:
                
                family = .iPhone
                marketingName = "iPhone 3G"
                identifiers = ["iPhone1,2"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "2",
                    maxVersion: "4.2.1",
                    unsupportedVersion: "4.2.5"
                )
                
            case .iPhone3GS:
                
                family = .iPhone
                marketingName = "iPhone 3GS"
                identifiers = ["iPhone2,1"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "3",
                    maxVersion: "6.1.6",
                    unsupportedVersion: "7"
                )
                
            case .iPhone4:
                
                family = .iPhone
                marketingName = "iPhone 4"
                identifiers = ["iPhone3,1", "iPhone3,2", "iPhone3,3"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "4",
                    maxVersion: "7.1.2",
                    unsupportedVersion: "8"
                )
                
            case .iPhone4S:
                
                family = .iPhone
                marketingName = "iPhone 4S"
                identifiers = ["iPhone4,1"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "5",
                    maxVersion: "9.3.6",
                    unsupportedVersion: "10"
                )
                
            case .iPhone5:
                
                family = .iPhone
                marketingName = "iPhone 5"
                identifiers = ["iPhone5,1", "iPhone5,2"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "6",
                    maxVersion: "10.3.4",
                    unsupportedVersion: "11"
                )
                
            case .iPhone5C:
                
                family = .iPhone
                marketingName = "iPhone 5C"
                identifiers = ["iPhone5,3", "iPhone5,4"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "7",
                    maxVersion: "10.3.3",
                    unsupportedVersion: "10.3.4"
                )
                
            case .iPhone5S:
                
                family = .iPhone
                marketingName = "iPhone 5S"
                identifiers = ["iPhone6,1", "iPhone6,2"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "7",
                    maxVersion: "12.5.5",
                    unsupportedVersion: "13"
                )
                
            case .iPhone6:
                
                family = .iPhone
                marketingName = "iPhone 6"
                identifiers = ["iPhone7,2"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "8",
                    maxVersion: "12.5.5",
                    unsupportedVersion: "13"
                )
                
            case .iPhone6Plus:
                
                family = .iPhone
                marketingName = "iPhone 6 Plus"
                identifiers = ["iPhone7,1"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "8",
                    maxVersion: "12.5.5",
                    unsupportedVersion: "13"
                )
                
            case .iPhone6S:
                
                family = .iPhone
                marketingName = "iPhone 6S"
                identifiers = ["iPhone8,1"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "9",
                    // TODO: (when discontinued) maxVersion: "LAST_IOS_15_VERSION",
                    unsupportedVersion: "16"
                )
                
            case .iPhone6SPlus:
                
                family = .iPhone
                marketingName = "iPhone 6S Plus"
                identifiers = ["iPhone8,2"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "9",
                    // TODO: (when discontinued) maxVersion: "LAST_IOS_15_VERSION",
                    unsupportedVersion: "16"
                )
                
            case .iPhoneSE:
                
                family = .iPhone
                marketingName = "iPhone SE"
                identifiers = ["iPhone8,4"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "9.3",
                    // TODO: (when discontinued) maxVersion: "LAST_IOS_15_VERSION",
                    unsupportedVersion: "16"
                )
                
            case .iPhone7:
                
                family = .iPhone
                marketingName = "iPhone 7"
                identifiers = ["iPhone9,1", "iPhone9,3"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "10.0.1",
                    // TODO: (when discontinued) maxVersion: "LAST_IOS_15_VERSION",
                    unsupportedVersion: "16"
                )
                
            case .iPhone7Plus:
                
                family = .iPhone
                marketingName = "iPhone 7 Plus"
                identifiers = ["iPhone9,2", "iPhone9,4"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "10.0.1",
                    // TODO: (when discontinued) maxVersion: "LAST_IOS_15_VERSION",
                    unsupportedVersion: "16"
                )
                
            case .iPhone8:
                
                family = .iPhone
                marketingName = "iPhone 8"
                identifiers = ["iPhone10,1", "iPhone10,4"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "11"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhone8Plus:
                
                family = .iPhone
                marketingName = "iPhone 8 Plus"
                identifiers = ["iPhone10,2", "iPhone10,5"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "11"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhoneX:
                
                family = .iPhone
                marketingName = "iPhone X"
                identifiers = ["iPhone10,3", "iPhone10,6"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "11.0.1"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhoneXR:
                
                family = .iPhone
                marketingName = "iPhone XR"
                identifiers = ["iPhone11,8"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "12"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhoneXS:
                
                family = .iPhone
                marketingName = "iPhone XS"
                identifiers = ["iPhone11,2"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "12"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhoneXSMax:
                
                family = .iPhone
                marketingName = "iPhone XS Max"
                identifiers = ["iPhone11,4", "iPhone11,6"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "12"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhone11:
                
                family = .iPhone
                marketingName = "iPhone 11"
                identifiers = ["iPhone12,1"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "13"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhone11Pro:
                
                family = .iPhone
                marketingName = "iPhone 11 Pro"
                identifiers = ["iPhone12,3"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "13"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhone11ProMax:
                
                family = .iPhone
                marketingName = "iPhone 11 Pro Max"
                identifiers = ["iPhone12,5"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "13"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhoneSE_2:
                
                family = .iPhone
                marketingName = "iPhone SE"
                generationalName = "iPhone SE (2nd Gen)"
                identifiers = ["iPhone12,8"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "13.4"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhone12:
                
                family = .iPhone
                marketingName = "iPhone 12"
                identifiers = ["iPhone13,2"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "14.1"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhone12Mini:
                
                family = .iPhone
                marketingName = "iPhone 12 mini"
                identifiers = ["iPhone13,1"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "14.1"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhone12Pro:
                
                family = .iPhone
                marketingName = "iPhone 12 Pro"
                identifiers = ["iPhone13,3"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "14.1"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhone12ProMax:
                
                family = .iPhone
                marketingName = "iPhone 12 Pro Max"
                identifiers = ["iPhone13,4"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "14.1"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhone13:
                
                family = .iPhone
                marketingName = "iPhone 13"
                identifiers = ["iPhone14,5"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "15"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhone13Mini:
                
                family = .iPhone
                marketingName = "iPhone 13 mini"
                identifiers = ["iPhone14,4"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "15"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhone13Pro:
                
                family = .iPhone
                marketingName = "iPhone 13 Pro"
                identifiers = ["iPhone14,2"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "15"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhone13ProMax:
                
                family = .iPhone
                marketingName = "iPhone 13 Pro Max"
                identifiers = ["iPhone14,3"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "15"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .iPhoneSE_3:
                
                family = .iPhone
                marketingName = "iPhone SE"
                generationalName = "iPhone SE (3rd Gen)"
                identifiers = ["iPhone14,6"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "15.4"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            // MARK: iPod
                                
            case .iPodTouch:
                
                family = .iPod
                marketingName = "iPod touch"
                identifiers = ["iPod1,1"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "1.1",
                    maxVersion: "3.1.3",
                    unsupportedVersion: "3.2"
                )
                
            case .iPodTouch_2:
                
                family = .iPod
                marketingName = "iPod touch"
                generationalName = "iPod touch (2nd Gen)"
                identifiers = ["iPod2,1"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "2.1.1",
                    maxVersion: "4.2.1",
                    unsupportedVersion: "4.2.5"
                )
                
            case .iPodTouch_3:
                
                family = .iPod
                marketingName = "iPod touch"
                generationalName = "iPod touch (3rd Gen)"
                identifiers = ["iPod3,1"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "3.1.1",
                    maxVersion: "5.1.1",
                    unsupportedVersion: "6"
                )
                
            case .iPodTouch_4:
                
                family = .iPod
                marketingName = "iPod touch"
                generationalName = "iPod touch (4th Gen)"
                identifiers = ["iPod4,1"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "4.1",
                    maxVersion: "6.1.6",
                    unsupportedVersion: "7"
                )
                
            case .iPodTouch_5:
                
                family = .iPod
                marketingName = "iPod touch"
                generationalName = "iPod touch (5th Gen)"
                identifiers = ["iPod5,1"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "6",
                    maxVersion: "9.3.5",
                    unsupportedVersion: "9.3.6"
                )
                
            case .iPodTouch_6:
                
                family = .iPod
                marketingName = "iPod touch"
                generationalName = "iPod touch (6th Gen)"
                identifiers = ["iPod7,1"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "8.4",
                    maxVersion: "12.5.5",
                    unsupportedVersion: "13"
                )
                
            case .iPodTouch_7:
                
                family = .iPod
                marketingName = "iPod touch"
                generationalName = "iPod touch (7th Gen)"
                identifiers = ["iPod9,1"]
                
                software = Software(
                    type: .iOS,
                    minVersion: "12.3.1",
                    // TODO: (when discontinued) maxVersion: "LAST_IOS_15_VERSION",
                    unsupportedVersion: "16"
                )
                
            // MARK: iPad
                
            case .iPad:
                
                family = .iPad
                marketingName = "iPad"
                identifiers = ["iPad1,1", "iPad1,2"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "3.2",
                    maxVersion: "5.1.1",
                    unsupportedVersion: "6"
                )
                
            case .iPad2:
                
                family = .iPad
                marketingName = "iPad 2"
                identifiers = ["iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "4.3",
                    maxVersion: "9.3.6",
                    unsupportedVersion: "10"
                )
                
            case .iPad_3:
                
                family = .iPad
                marketingName = "iPad"
                generationalName = "iPad (3rd Gen)"
                identifiers = ["iPad3,1", "iPad3,2", "iPad3,3"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "5.1",
                    maxVersion: "9.3.6",
                    unsupportedVersion: "10"
                )
                
            case .iPadMini:
                
                family = .iPad
                marketingName = "iPad mini"
                identifiers = ["iPad2,5", "iPad2,6", "iPad2,7"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "6",
                    maxVersion: "9.3.6",
                    unsupportedVersion: "10"
                )
                
            case .iPad_4:
                
                family = .iPad
                marketingName = "iPad"
                generationalName = "iPad (4th Gen)"
                identifiers = ["iPad3,4", "iPad3,5", "iPad3,6"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "6",
                    maxVersion: "10.3.4",
                    unsupportedVersion: "11"
                )
                
            case .iPadAir:
                
                family = .iPad
                marketingName = "iPad Air"
                identifiers = ["iPad4,1", "iPad4,2", "iPad4,3"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "7.0.3",
                    maxVersion: "12.5.5",
                    unsupportedVersion: "13"
                )
                
            case .iPadMini2:
                
                family = .iPad
                marketingName = "iPad mini 2"
                identifiers = ["iPad4,4", "iPad4,5", "iPad4,6"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "7.0.3",
                    maxVersion: "12.5.5",
                    unsupportedVersion: "13"
                )
                
            case .iPadMini3:
                
                family = .iPad
                marketingName = "iPad mini 3"
                identifiers = ["iPad4,7", "iPad4,8", "iPad4,9"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "8.1",
                    maxVersion: "12.5.5",
                    unsupportedVersion: "13"
                )
                
            case .iPadMini4:
                
                family = .iPad
                marketingName = "iPad mini 4"
                identifiers = ["iPad5,1", "iPad5,2"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "9",
                    // TODO: (when deprecated) maxVersion: "LAST_IOS_15_VERSION",
                    unsupportedVersion: "16"
                )
                
            case .iPadAir2:
                
                family = .iPad
                marketingName = "iPad Air 2"
                identifiers = ["iPad5,3", "iPad5,4"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "8.1",
                    // TODO: (when deprecated) maxVersion: "LAST_IOS_15_VERSION",
                    unsupportedVersion: "16"
                )
                
            case .iPadPro9:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (9.7-inch)"
                identifiers = ["iPad6,3", "iPad6,4"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "9.3"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPadPro12:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (12.9-inch)"
                identifiers = ["iPad6,7", "iPad6,8"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "9.1"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPad_5:
                
                family = .iPad
                marketingName = "iPad"
                generationalName = "iPad (5th Gen)"
                identifiers = ["iPad6,11", "iPad6,12"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "10.3"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPadPro12_2:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (12.9-inch) (2nd Gen)"
                identifiers = ["iPad7,1", "iPad7,2"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "10.3.2"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPadPro10:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (10.5-inch)"
                identifiers = ["iPad7,3", "iPad7,4"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "10.3.2"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPad_6:
                
                family = .iPad
                marketingName = "iPad"
                generationalName = "iPad (6th Gen)"
                identifiers = ["iPad7,5", "iPad7,6"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "11.3"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPad_7:
                
                family = .iPad
                marketingName = "iPad"
                generationalName = "iPad (7th Gen)"
                identifiers = ["iPad7,11", "iPad7,12"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "13.1"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPadPro11:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (11-inch)"
                identifiers = ["iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "12.1"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPadPro12_3:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (12.9-inch) (3rd Gen)"
                identifiers = ["iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "12.1"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPadPro11_2:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (11-inch) (2nd Gen)"
                identifiers = ["iPad8,9", "iPad8,10"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "13.4"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPadPro12_4:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName =  "iPad Pro (12.9-inch) (4th Gen)"
                identifiers = ["iPad8,11", "iPad8,12"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "13.4"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPadMini_5:
                
                family = .iPad
                marketingName = "iPad mini"
                generationalName = "iPad mini (5th Gen)"
                identifiers = ["iPad11,1", "iPad11,2"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "12.2"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPadAir_3:
                
                family = .iPad
                marketingName = "iPad Air"
                generationalName = "iPad Air (3rd Gen)"
                identifiers = ["iPad11,3", "iPad11,4"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "12.2"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPad_8:
                
                family = .iPad
                marketingName = "iPad"
                generationalName = "iPad (8th Gen)"
                identifiers = ["iPad11,6", "iPad11,7"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "14"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPadAir_4:
                
                family = .iPad
                marketingName = "iPad Air"
                generationalName = "iPad Air (4th Gen)"
                identifiers = ["iPad13,1", "iPad13,2"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "14"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPadPro11_3:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (11-inch) (3rd Gen)"
                identifiers = ["iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "14.5"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPadPro12_5:
                
                family = .iPad
                marketingName = "iPad Pro"
                generationalName = "iPad Pro (12.9-inch) (5th Gen)"
                identifiers = ["iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "14.5"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPad_9:
                
                family = .iPad
                marketingName = "iPad"
                generationalName = "iPad (9th Gen)"
                identifiers = ["iPad12,1", "iPad12,2"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "15"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPadMini_6:
                
                family = .iPad
                marketingName = "iPad mini"
                generationalName = "iPad mini (6th Gen)"
                identifiers = ["iPad14,1", "iPad14,2"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "15"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .iPadAir_5:
                
                family = .iPad
                marketingName = "iPad Air"
                generationalName = "iPad Air (5th Gen)"
                identifiers = ["iPad13,6", "iPad13,7"]
                
                software = Software(
                    type: .iPadOS,
                    minVersion: "15.4"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            // MARK: Apple Watch
                
            case .appleWatch:
                
                family = .appleWatch
                marketingName = "Apple Watch"
                identifiers = ["Watch1,1", "Watch1,2"]
                
                software = Software(
                    type: .watchOS,
                    minVersion: "1",
                    maxVersion: "4.3.2",
                    unsupportedVersion: "5"
                )
                
            case .appleWatchS1:
                
                family = .appleWatch
                marketingName = "Apple Watch Series 1"
                identifiers = ["Watch2,6", "Watch2,7"]
                
                software = Software(
                    type: .watchOS,
                    minVersion: "3",
                    maxVersion: "6.3",
                    unsupportedVersion: "7"
                )
                
            case .appleWatchS2:
                
                family = .appleWatch
                marketingName = "Apple Watch Series 2"
                identifiers = ["Watch2,3", "Watch2,4"]
                
                software = Software(
                    type: .watchOS,
                    minVersion: "3",
                    maxVersion: "6.3",
                    unsupportedVersion: "7"
                )
                
            case .appleWatchS3:
                
                family = .appleWatch
                marketingName = "Apple Watch Series 3"
                identifiers = ["Watch3,1", "Watch3,2", "Watch3,3", "Watch3,4"]
                
                software = Software(
                    type: .watchOS,
                    minVersion: "4",
                    // TODO: (when deprecated) maxVersion: "LAST_WATCHOS_8_VERSION",
                    unsupportedVersion: "9"
                )
                
            case .appleWatchS4:
                
                family = .appleWatch
                marketingName = "Apple Watch Series 4"
                identifiers = ["Watch4,1", "Watch4,2", "Watch4,3", "Watch4,4"]
                
                software = Software(
                    type: .watchOS,
                    minVersion: "5"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .appleWatchS5:
                
                family = .appleWatch
                marketingName = "Apple Watch Series 5"
                identifiers = ["Watch5,1", "Watch5,2", "Watch5,3", "Watch5,4"]
                
                software = Software(
                    type: .watchOS,
                    minVersion: "6"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .appleWatchSE:
                
                family = .appleWatch
                marketingName = "Apple Watch SE"
                identifiers = ["Watch5,9", "Watch5,10", "Watch5,11", "Watch5,12"]
                
                software = Software(
                    type: .watchOS,
                    minVersion: "7"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .appleWatchS6:
                
                family = .appleWatch
                marketingName = "Apple Watch Series 6"
                identifiers = ["Watch6,1", "Watch6,2", "Watch6,3", "Watch6,4"]
                
                software = Software(
                    type: .watchOS,
                    minVersion: "7"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            case .appleWatchS7:
                
                family = .appleWatch
                marketingName = "Apple Watch Series 7"
                identifiers = ["Watch6,6", "Watch6,7", "Watch6,8", "Watch6,9"]
                
                software = Software(
                    type: .watchOS,
                    minVersion: "8"
                    // TODO: (when deprecated) maxVersion: "...",
                    // TODO: (when deprecated) unsupportedVersion: "..."
                )
                
            // MARK: Apple TV
                 
            case .appleTV:
                
                family = .appleTV
                marketingName = "Apple TV"
                identifiers = ["AppleTV1,1"]
                
                software = Software(
                    type: .tvOS,
                    minVersion: "1",
                    maxVersion: "3.0.2",
                    unsupportedVersion: "4"
                )
                
            case .appleTV_2:
                
                family = .appleTV
                marketingName = "Apple TV"
                generationalName = "Apple TV (2nd Gen)"
                identifiers = ["AppleTV2,1"]
                
                software = Software(
                    type: .tvOS,
                    minVersion: "4",
                    maxVersion: "6.2.1",
                    unsupportedVersion: "7"
                )
                
            case .appleTV_3:
                
                family = .appleTV
                marketingName = "Apple TV"
                generationalName = "Apple TV (3nd Gen)"
                identifiers = ["AppleTV3,1", "AppleTV3,2"]
                
                software = Software(
                    type: .tvOS,
                    minVersion: "5",
                    maxVersion: "7.9",
                    unsupportedVersion: "9"
                )
                
            case .appleTVHD:
                
                family = .appleTV
                marketingName = "Apple TV HD"
                identifiers = ["AppleTV5,3"]
                
                software = Software(
                    type: .tvOS,
                    minVersion: "9"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .appleTV4K:
                
                family = .appleTV
                marketingName = "Apple TV 4K"
                identifiers = ["AppleTV6,2"]
                
                software = Software(
                    type: .tvOS,
                    minVersion: "11"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .appleTV4K_2:
                
                family = .appleTV
                marketingName = "Apple TV 4K"
                generationalName = "Apple TV 4K (2nd Gen)"
                identifiers = ["AppleTV11,1"]
                
                software = Software(
                    type: .tvOS,
                    minVersion: "14.5"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                       
            // MARK: AirTag
                
            case .airtag:
                
                family = .airTag
                marketingName = "AirTag"
                identifiers = ["AirTag1,1"]
                
                software = Software(
                    type: .firmware,
                    minVersion: "1.0.225"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                    
            // MARK: AirPods
                
            case .airpods:
                
                family = .airPods
                marketingName = "AirPods"
                identifiers = ["AirPods1,1"]
                
                software = Software(
                    type: .firmware,
                    minVersion: "3.3.1",
                    maxVersion: "6.8.8" // is this actually the "max" version? this is the latest update as of 2019
                    // TODO: (when discontinued) unsupportedVersion: "..." // 2B584 ?
                )
                
            case .airpods_2:
                
                family = .airPods
                marketingName = "AirPods"
                generationalName = "AirPods (2nd Gen)"
                identifiers = ["AirPods1,2", "AirPods2,1"]
                
                software = Software(
                    type: .firmware,
                    minVersion: "6.3.2"
                    // TODO: (when discontinued) maxVersion: "...", // latest version: 4E71
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .airpods_3:
                
                family = .airPods
                marketingName = "AirPods"
                generationalName = "AirPods (3rd Gen)"
                identifiers = ["AirPods1,3", "Audio2,1"]
                
                software = Software(
                    type: .firmware,
                    minVersion: "3E751"
                    // TODO: (when discontinued) maxVersion: "...", // latest version: 4E71
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .airpodsPro:
                
                family = .airPods
                marketingName = "AirPods Pro"
                identifiers = ["iProd8,1", "AirPods2,2", "AirPodsPro1,1"]
                
                software = Software(
                    type: .firmware,
                    minVersion: "2B584"
                    // TODO: (when discontinued) maxVersion: "...", // latest version: 4E71
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .airpodsMax:
                
                family = .airPods
                marketingName = "AirPods Max"
                identifiers = ["iProd8,6", "AirPodsMax1,1"]
                
                software = Software(
                    type: .firmware,
                    minVersion: "3C16"
                    // TODO: (when discontinued) maxVersion: "...", // latest version: 4E71
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            // MARK: HomePod

            case .homepod:
                
                family = .homePod
                marketingName = "HomePod"
                identifiers = ["AudioAccessory1,1", "AudioAccessory1,2"]
                
                // HomePod has weird versioning in some cases.
                // Some OTA builds are prefixed with "9.9" - do I need to handle this?
                // i.e. "9.9.11.2.5"
                
                software = Software(
                    type: .audioOS,
                    minVersion: "11.2.5"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            case .homepodMini:
                
                family = .homePod
                marketingName = "HomePod mini"
                identifiers = ["AudioAccessory5,1"]
                
                // HomePod has weird versioning in some cases.
                // Some OTA builds are prefixed with "9.9" - do I need to handle this?
                // i.e. "9.9.11.2.5"
                
                software = Software(
                    type: .audioOS,
                    minVersion: "14.2"
                    // TODO: (when discontinued) maxVersion: "...",
                    // TODO: (when discontinued) unsupportedVersion: "..."
                )
                
            // MARK: Other
                
            case .unknown:
                
                family = .unknown
                marketingName = "Unknown"
                identifiers = ["unknown"]
                
                software = Software(
                    type: .firmware,
                    minVersion: Version.invalid.asString(format: .compact)
                )
                
            }
            
            return (
                family,
                (marketingName, generationalName ?? marketingName),
                identifiers,
                software
            )
            
        }
        
    }
    
}
