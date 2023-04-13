//
//  UIDevice+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 6/12/22.
//

import UIKit
import Espresso // Ignore warning, we need this for SPM modules

public extension UIDevice {

    /// An object that represents the current Apple device.
    static var currentAppleDevice: AppleDevice {
        return AppleDevice.current
    }
    
}
