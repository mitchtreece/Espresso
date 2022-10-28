//
//  AppleDevice+Helpers.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/22.
//

import Foundation

public extension AppleDevice /* Helpers */ {
    
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
    
    /// Flag indicating whether this device is an Apple Watch.
    var isWatch: Bool {
        return self.family == .appleWatch
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
        return (self.isLegacyPhone || self.isLegacyPad || self.isPod)
    }

    /// Flag indicating whether this device is a modern iPhone (edge-to-edge screen without a home button).
    var isModernPhone: Bool {
        return (self.family == .iPhone && !self.isLegacyPhone)
    }

    /// Flag indicating whether this device is a legacy iPhone (non-edge-to-edge screen with a home button).
    var isLegacyPhone: Bool {

        return self.family == .iPhone && (
            self.type == .iPhone ||
            self.type == .iPhone3G || self.type == .iPhone3GS ||
            self.type == .iPhone4 || self.type == .iPhone4S ||
            self.type == .iPhone5 || self.type == .iPhone5C || self.type == .iPhone5S ||
            self.type == .iPhone6 || self.type == .iPhone6Plus || self.type == .iPhone6S || self.type == .iPhone6SPlus ||
            self.type == .iPhone7 || self.type == .iPhone7Plus ||
            self.type == .iPhone8 || self.type == .iPhone8Plus ||
            self.type == .iPhoneSE || self.type == .iPhoneSE_2 || self.type == .iPhoneSE_3
        )
                
    }

    /// Flag indicating whether this device is a modern iPad (edge-to-edge screen without a home button).
    var isModernPad: Bool {
        return (self.family == .iPad && !self.isLegacyPad)
    }

    /// Flag indicating whether this device is a legacy iPad (non-edge-to-edge screen with a home button).
    var isLegacyPad: Bool {

        return self.family == .iPad && (
            self.type == .iPad || self.type == .iPad2 ||
            self.type == .iPad_3 || self.type == .iPad_4 || self.type == .iPad_5 || self.type == .iPad_6 ||
            self.type == .iPad_7 || self.type == .iPad_8 || self.type == .iPad_9 ||
            self.type == .iPadMini || self.type == .iPadMini2 || self.type == .iPadMini3 || self.type == .iPadMini4 ||
            self.type == .iPadMini_5 ||
            self.type == .iPadAir || self.type == .iPadAir2 || self.type == .iPadAir_3 ||
            self.type == .iPadPro9 || self.type == .iPadPro12 || self.type == .iPadPro12_2 || self.type == .iPadPro10
        )
        
    }
    
    /// Flag indicating whether this device is compact (small-screen).
    var isCompact: Bool {
        return self.isCompactPhone
    }
    
    /// Flag indicating whether this device is a compact iPhone (4.7" or lower screen-size).
    var isCompactPhone: Bool {
        
        return self.family == .iPhone && (
            self.type == .iPhone ||
            self.type == .iPhone3G || self.type == .iPhone3GS ||
            self.type == .iPhone4 || self.type == .iPhone4S ||
            self.type == .iPhone5 || self.type == .iPhone5C || self.type == .iPhone5S ||
            self.type == .iPhone6 || self.type == .iPhone6S ||
            self.type == .iPhone7 ||
            self.type == .iPhone8 ||
            self.type == .iPhoneSE || self.type == .iPhoneSE_2 || self.type == .iPhoneSE_3
        )
        
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
