//
//  UIApplication+Events.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import UIKit

private struct AssociatedKeys {
    static var events: UInt8 = 0
}

public extension UIApplication /* Events */ {
    
    /// The application's event collection.
    var events: UIApplicationEvents {
        
        if let events = objc_getAssociatedObject(self, &AssociatedKeys.events) as? UIApplicationEvents {
            return events
        }

        let events = UIApplicationEvents()

        objc_setAssociatedObject(
            self,
            &AssociatedKeys.events,
            events,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )

        return events
        
    }
    
}
