//
//  LocalAppleDevice.swift
//  Espresso
//
//  Created by Mitch Treece on 6/13/22.
//

import UIKit

/// Representation of the local Apple hardware device.
public class LocalAppleDevice: AppleDevice {
    
    /// The `UIDevice` backing this Apple device.
    public let uiDevice: UIDevice
    
    /// The device's current system software version.
    public var currentSoftwareVersion: Version {
        return (try? Version(self.uiDevice.systemVersion)) ?? .invalid
    }
    
    internal init(identifier: String,
                  uiDevice: UIDevice) {
        
        self.uiDevice = uiDevice
        super.init(identifier: identifier)
        
    }
    
}

public extension LocalAppleDevice /* Helpers */ {
    
    /// Flag indicating whether this device is a simulator.
    var isSimulator: Bool {
        return self._isSimulator
    }
    
    /// Flag indicating whether this device is an iPhone.
    var isPhone: Bool {
        return self.family == .iPhone
    }
    
    /// Flag indicating whether this device is an iPad.
    var isPad: Bool {
        return self.family == .iPad
    }
    
    /// Flag indicating whether this device is an iPod.
    var isPod: Bool {
        return self.family == .iPod
    }
    
    /// Flag indicating whether this device is an Apple TV.
    var isTV: Bool {
        return self.family == .appleTV
    }
    
    /// Flag indicating whether this device is modern (edge-to-edge screen without a home button).
    var isModern: Bool {
        return (self.isModernPhone || self.isModernPad)
    }
    
    /// Flag indicating whether this device is legacy (non-edge-to-edge screen with a home button).
    var isLegacy: Bool {
        return (self.isLegacyPhone || self.isLegacyPad)
    }
    
    /// Flag indicating whether this device is a modern iPhone (edge-to-edge screen without a home button).
    var isModernPhone: Bool {
                
        return (
            self.type == .iPhoneX ||
            self.type == .iPhoneXR ||
            self.type == .iPhoneXS ||
            self.type == .iPhoneXSMax ||
            self.type == .iPhone11 ||
            self.type == .iPhone11Pro ||
            self.type == .iPhone11ProMax ||
            self.type == .iPhone12 ||
            self.type == .iPhone12Mini ||
            self.type == .iPhone12Pro ||
            self.type == .iPhone12ProMax ||
            self.type == .iPhone13 ||
            self.type == .iPhone13Mini ||
            self.type == .iPhone13Pro ||
            self.type == .iPhone13ProMax
        )
        
    }
    
    /// Flag indicating whether this device is a legacy iPhone (non-edge-to-edge screen with a home button).
    var isLegacyPhone: Bool {
        return !self.isModernPhone
    }
    
    /// Flag indicating whether this device is a modern iPad (edge-to-edge screen without a home button).
    var isModernPad: Bool {
        
        return (
            self.type == .iPadPro11 ||
            self.type == .iPadPro11_2 ||
            self.type == .iPadPro11_3 ||
            self.type == .iPadPro12_3 ||
            self.type == .iPadPro12_4 ||
            self.type == .iPadPro12_5 ||
            self.type == .iPadMini_6
        )
        
    }
    
    /// Flag indicating whether this device is a legacy iPad (non-edge-to-edge screen with a home button).
    var isLegacyPad: Bool {
        return !self.isModernPad
    }
    
    /// Flag indicating whether this device is jailbroken.
    ///
    /// This is a simple check and **not** guaranteed to be accurate.
    var isJailbroken: Bool {

        // Check for common jailbroken files

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

        // Check for sandbox violation

        do {
            try "jailbroken".write(toFile: "/private/jailbroken.txt", atomically: true, encoding: .utf8)
            return true
        }
        catch {
            return false
        }

    }
    
}
