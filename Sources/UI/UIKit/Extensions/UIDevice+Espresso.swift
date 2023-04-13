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
        
        return AppleDevice
            .modelIdentifier(simulatorPrefix: false)
        
    }
    
    /// An object that represents the current Apple device.
    static var currentAppleDevice: AppleDevice {
        return AppleDevice.current
    }
    
}
