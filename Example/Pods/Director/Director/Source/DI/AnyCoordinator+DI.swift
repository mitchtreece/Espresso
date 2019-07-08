//
//  AnyCoordinator+DI.swift
//  Director
//
//  Created by Mitch Treece on 7/6/19.
//

import Swinject

private struct AssociatedKeys {
    static var resolver: UInt8 = 0
}

public extension AnyCoordinator /* DI */ {
    
    internal var _resolver: Resolver? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.resolver) as? Resolver
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.resolver, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// The coordinator's dependency resolver.
    var resolver: Resolver? {
        
        if let resolver = self._resolver {
            return resolver
        }
        else if let coord = self as? ViewCoordinator,
            let resolver = coord.parentCoordinator?.resolver {
            return resolver
        }
        
        return nil
        
    }
    
}
