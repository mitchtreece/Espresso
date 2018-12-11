//
//  UIViewControllerCoordinating.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import UIKit

private struct AssociatedKeys {
    static var coordinator: UInt8 = 0
}

/**
 Protocol describing a way for a `UIViewController` to access it's associated coordinator.
 */
public protocol UIViewControllerCoordinating {}

public extension UIViewControllerCoordinating {
    
    internal weak var _coordinator: Coordinator? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.coordinator) as? Coordinator
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.coordinator, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// The view controller's associated coordinator instance.
    public var coordinator: Coordinator? {
        return self._coordinator
    }
    
    /**
     Fetches & casts the view controller's coordinator as a concrete type.
     - Parameter type: The coordinator type.
     - Returns: A typed `Coordinator` instance.
     */
    public func coordinator<C: Coordinator>(as type: C.Type) -> C? {
        return self.coordinator as? C
    }
    
}
