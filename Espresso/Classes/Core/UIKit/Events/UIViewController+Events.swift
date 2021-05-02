//
//  UIViewController+Events.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import UIKit

private struct AssociatedKeys {
    static var events: UInt8 = 0
}

public extension UIViewController /* Events */ {
    
    /// The view controller's event collection.
    var events: UIViewControllerEvents {
        
        if let events = objc_getAssociatedObject(self, &AssociatedKeys.events) as? UIViewControllerEvents {
            return events
        }

        let events = UIViewControllerEvents(viewController: self)

        objc_setAssociatedObject(
            self,
            &AssociatedKeys.events,
            events,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )

        return events
        
    }
    
}
