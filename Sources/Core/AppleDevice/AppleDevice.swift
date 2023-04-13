//
//  DeviceType.swift
//  Espresso
//
//  Created by Mitch Treece on 6/13/22.
//

import Foundation

/// Representation of an Apple device.
public class AppleDevice {
    
    internal static let simulatorPrefix = "__sim_"
    
    /// Representation of the various Apple device families.
    public enum Family: String, CaseIterable {
        
        /// An iPhone device family.
        case iPhone
        
        /// An iPod device family.
        case iPod
        
        /// An iPad device family.
        case iPad
        
        /// An Apple Watch device family.
        case appleWatch = "Apple Watch"
        
        /// An Apple TV device family.
        case appleTV = "Apple TV"
        
        /// An AirTag device family.
        case airTag = "AirTag"
        
        /// An AirPods device family.
        case airPods = "AirPods"
        
        /// A HomePod device family.
        case homePod = "HomePod"
        
        /// An unknown device family.
        case unknown = "Unknown"
        
        /// The device family's software type.
        public var software: Software {
            
            switch self {
            case .iPhone: return .iOS
            case .iPod: return .iOS
            case .iPad: return .iPadOS
            case .appleWatch: return .watchOS
            case .appleTV: return .tvOS
            case .airTag: return .firmware
            case .airPods: return .firmware
            case .homePod: return .audioOS
            case .unknown: return .unknown
            }
            
        }

    }
    
    /// Representation of the various Apple device softwares.
    public enum Software: String {
        
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
        
        /// An unknown software type.
        case unknown
        
    }
    
    /// The device's type.
    public private(set) var type: DeviceType = .unknown
    
    /// The device's identifier.
    ///
    /// i.e. "iPhone1,1", "iPhone10,3", "iPhone14,3"
    public let identifier: String
        
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
        return self.type.info.name.generational
    }

    /// The device's system software name.
    public var softwareName: String {
        
        let software = self.family.software
                        
        switch software {
        case .iOS: return (self.softwareVersion >= "4") ? "iOS" : "iPhone OS"
        case .iPadOS: return (self.softwareVersion >= "13.1") ? "iPadOS" : "iOS"
        case .tvOS: return (self.softwareVersion >= "9") ? "tvOS" : "Apple TV Software"
        default: return software.rawValue
        }
        
    }
    
    /// The device's system software version.
    public var softwareVersion: Version {
                
        let osVersion = ProcessInfo()
            .operatingSystemVersion
        
        return Version(
            UInt(osVersion.majorVersion),
            UInt(osVersion.minorVersion),
            UInt(osVersion.patchVersion)
        )
        
    }
    
    /// The current Apple device.
    public static var current: AppleDevice {
        return AppleDevice()
    }

    private init() {
        
        var cleanIdentifier = Self.modelIdentifier(simulatorPrefix: true)

        if cleanIdentifier.hasPrefix(Self.simulatorPrefix) {

            self._isSimulator = true

            cleanIdentifier = cleanIdentifier.replacingOccurrences(
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
    
    internal static func modelIdentifier(simulatorPrefix: Bool) -> String {
        
        #if targetEnvironment(simulator)
            let isSimulatedEnvironment = true
        #else
            let isSimulatedEnvironment = false
        #endif

        var identifier: String = ""
        
        if isSimulatedEnvironment {
            
            if let simulatedIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                
                identifier = simulatorPrefix ?
                    "\(AppleDevice.simulatorPrefix)\(simulatedIdentifier)" :
                    simulatedIdentifier
                
            }

        }
        else {

            var systemInfo = utsname()
            uname(&systemInfo)

            let mirror = Mirror(reflecting: systemInfo.machine)

            identifier = mirror.children.reduce("") { (deviceId, element) in

                guard let value = element.value as? Int8, value != 0 else { return deviceId }
                return deviceId + String(UnicodeScalar(UInt8(value)))

            }
            
        }

        return identifier
        
    }
    
}
