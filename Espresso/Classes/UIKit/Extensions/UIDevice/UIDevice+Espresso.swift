//
//  UIDevice+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 6/12/22.
//

import UIKit

public extension UIDevice {
 
    /// Flag indicating whether the current device is a simulator.
    var isSimulator: Bool {
        return (self.deviceType(includeSimulator: true) == .simulator)
    }
    
    /// Flag indicating whether the current device is a phone.
    var isPhone: Bool {
        
        return self.deviceType()
            .displayName
            .contains("iPhone")
        
    }
    
    /// Flag indicating whether the current device is an iPad.
    var isPad: Bool {
        
        return self.deviceType()
            .displayName
            .contains("iPad")
        
    }
    
    /// Flag indicating whether the current device is an iPod.
    var isPod: Bool {
        
        return self.deviceType()
            .displayName
            .contains("iPod")
        
    }
    
    /// Flag indicating whether the current device is a TV.
    var isTV: Bool {
        
        return self.deviceType()
            .displayName
            .contains("TV")
        
    }
    
    /// Flag indicating whether the current device is a modern iPhone (edge-to-edge screen without a home button).
    var isModernPhone: Bool {
        
        let device = self.deviceType()
        
        return (
            device == .iPhoneX ||
            device == .iPhoneXR ||
            device == .iPhoneXS ||
            device == .iPhoneXSMax ||
            device == .iPhone11 ||
            device == .iPhone11Pro ||
            device == .iPhone11ProMax ||
            device == .iPhone12 ||
            device == .iPhone12Mini ||
            device == .iPhone12Pro ||
            device == .iPhone12ProMax ||
            device == .iPhone13 ||
            device == .iPhone13Mini ||
            device == .iPhone13Pro ||
            device == .iPhone13ProMax
        )
        
    }
    
    /// Flag indicating whether the current device is a modern iPad (edge-to-edge screen without a home button).
    var isModernPad: Bool {
        
        let device = self.deviceType()
        
        return (
            device == .iPadPro11 ||
            device == .iPadPro11_2 ||
            device == .iPadPro11_3 ||
            device == .iPadPro12_3 ||
            device == .iPadPro12_4 ||
            device == .iPadPro12_5 ||
            device == .iPadMini_6
        )
        
    }
    
    /// Flag indicating whether the current device is modern (edge-to-edge screen without a home button).
    var isModern: Bool {
        return (self.isModernPhone || self.isModernPad)
    }
    
    /// Flag indicating whether the current device is a legacy iPhone (non-edge-to-edge screen with a home button).
    var isLegacyPhone: Bool {
        return !self.isModernPhone
    }
    
    /// Flag indicating whether the current device is a legacy iPad (non-edge-to-edge screen with a home button).
    var isLegacyPad: Bool {
        return !self.isModernPad
    }
    
    /// Flag indicating whether the current device is legacy (non-edge-to-edge screen with a home button).
    var isLegacy: Bool {
        return (self.isLegacyPhone || self.isLegacyPad)
    }
    
    /// Gets a device-type for the current device; optionally including the simulator if desired.
    /// - parameter includeSimulator: Flag indicating whether the `simulator` device type should be reported or not.
    /// If the current device is a simulator and this is set to _false_, the emulated device will be returned instead.
    /// - returns: A new device type object.
    func deviceType(includeSimulator: Bool = false) -> DeviceType {
        
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
        
        return DeviceType(identifier: machineIdentifier)
        
    }
    
}
