//
//  UIDevice+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 6/12/22.
//

import UIKit

public extension UIDevice {
    
    /// The current device's model identifier.
    ///
    /// i.e. "iPhone1,1", "iPhone10,3", "iPhone14,3"
    var modelIdentifier: String {
        return modelIdentifier(simulatorPrefix: false)
    }
    
    /// Flag indicating whether this device is a simulator.
    var isSimulator: Bool {
        
        return asAppleDevice()
            .isSimulator
        
    }
    
    /// Flag indicating whether this device is an iPhone.
    var isPhone: Bool {
        
        return asAppleDevice()
            .isPhone
        
    }
    
    /// Flag indicating whether this device is an iPad.
    var isPad: Bool {
        
        return asAppleDevice()
            .isPad
        
    }
    
    /// Flag indicating whether this device is an iPod.
    var isPod: Bool {
        
        return asAppleDevice()
            .isPod
        
    }
    
    /// Flag indicating whether this device is an Apple TV.
    var isTV: Bool {
        
        return asAppleDevice()
            .isTV
        
    }
    
    /// Flag indicating whether this device is modern (edge-to-edge screen without a home button).
    var isModern: Bool {
        
        return asAppleDevice()
            .isModern
        
    }
    
    /// Flag indicating whether this device is legacy (non-edge-to-edge screen with a home button).
    var isLegacy: Bool {
        
        return asAppleDevice()
            .isLegacy
        
    }
    
    /// Flag indicating whether this device is a modern iPhone (edge-to-edge screen without a home button).
    var isModernPhone: Bool {
        
        return asAppleDevice()
            .isModernPhone
        
    }
    
    /// Flag indicating whether this device is a legacy iPhone (non-edge-to-edge screen with a home button).
    var isLegacyPhone: Bool {
        
        return asAppleDevice()
            .isLegacyPhone
        
    }
    
    /// Flag indicating whether this device is a modern iPad (edge-to-edge screen without a home button).
    var isModernPad: Bool {
        
        return asAppleDevice()
            .isModernPad
        
    }
    
    /// Flag indicating whether this device is a legacy iPad (non-edge-to-edge screen with a home button).
    var isLegacyPad: Bool {
        
        return asAppleDevice()
            .isLegacyPad
        
    }
    
    /// Flag indicating whether this device is jailbroken.
    ///
    /// This is a simple check and **not** guaranteed to be accurate.
    var isJailbroken: Bool {
        
        return asAppleDevice()
            .isJailbroken
        
    }
    
    /// Gets the Apple device representation of this `UIDevice`.
    func asAppleDevice() -> AppleDevice {
        return AppleDevice(device: self)
    }
    
    internal func modelIdentifier(simulatorPrefix: Bool) -> String {
        
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
