//
//  Coordinator+Resolver.swift
//  Espresso
//
//  Created by Mitch Treece on 3/9/19.
//

import Swinject

private struct AssociatedKeys {
    static var resolver: UInt8 = 0
}

public extension AnyCoordinatorBase /* Resolver */ {
    
    internal var _resolver: Resolver? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.resolver) as? Resolver
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.resolver, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// The coordinator's assigned resolver.
    var resolver: Resolver? {

        if let r = self._resolver {
            return r
        }
        else if let coordinator = self as? Coordinator, let r = coordinator.parentCoordinator?.resolver {
            return r
        }
        
        return nil
        
    }
    
}
