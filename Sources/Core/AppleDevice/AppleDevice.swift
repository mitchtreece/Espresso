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
        
        /// A Vision device family.
        case vision = "Vision"
        
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
            case .vision: return .visionOS
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
    public enum Software: String, CaseIterable {
        
        /// An iOS software type.
        case iOS
        
        /// An iPadOS software type.
        case iPadOS
        
        /// A visionOS software type.
        case visionOS
        
        /// A watchOS software type.
        case watchOS
        
        /// A tvOS software type.
        case tvOS
        
        /// An audioOS software type.
        case audioOS
        
        /// A generic firmware software type.
        case firmware = "Firmware"
        
        /// An unknown software type.
        case unknown = "Unknown"
        
    }
    
    /// Representation of the various Apple device processors.
    public enum Processor: String, CaseIterable {
        
        case intelPentiumM_1ghz = "Intel Pentium M (1GHz)"
        
        case apl0098 = "APL0098"
        case apl0278 = "APL0278"
        case apl0298 = "APL0298"
        case apl2298 = "APL2298"
        
        case a4 = "Apple A4"
        case a5 = "Apple A5"
        case a5x = "Apple A5X"
        case a6 = "Apple A6"
        case a6x = "Apple A6X"
        case a7 = "Apple A7"
        case a8 = "Apple A8"
        case a8x = "Apple A8X"
        case a9 = "Apple A9"
        case a9x = "Apple A9X"
        case a10 = "Apple A10 Fusion"
        case a10x = "Apple A10X Fusion"
        case a11 = "Apple A11 Bionic"
        case a12 = "Apple A12 Bionic"
        case a12x = "Apple A12X Bionic"
        case a12z = "Apple A12Z Bionic"
        case a13 = "Apple A13 Bionic"
        case a14 = "Apple A14 Bionic"
        case a15 = "Apple A15 Bionic"
        case a16 = "Apple A16 Bionic"
        case a17 = "Apple A17 Pro"
        
        case m1 = "Apple M1"
        case m1Pro = "Apple M1 Pro"
        case m1Max = "Apple M1 Max"
        case m1Ultra = "Apple M1 Ultra"
        case m2 = "Apple M2"
        case m2Pro = "Apple M2 Pro"
        case m2Max = "Apple M2 Max"
        case m2Ultra = "Apple M2 Ultra"
        case m3 = "Apple M3"
        case m3Pro = "Apple M3 Pro"
        case m3Max = "Apple M3 Max"
        case m4 = "Apple M4"
        
        case s1 = "Apple S1"
        case s1p = "Apple S1P"
        case s2 = "Apple S2"
        case s3 = "Apple S3"
        case s4 = "Apple S4"
        case s5 = "Apple S5"
        case s6 = "Apple S6"
        case s7 = "Apple S7"
        case s8 = "Apple S8"
        case s9 = "Apple S9"
        
        case w1 = "Apple W1"
        case h1 = "Apple H1"
        case h2 = "Apple H2"
        
        case none = "None"
        case unknown = "Unknown"

        /// The processor's name.
        public var name: String {
            return self.rawValue
        }
        
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
    
    /// The device's processor.
    public var processor: Processor {
        return self.type.info.processor
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
