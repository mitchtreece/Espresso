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
    
    public var resolver: Resolver? {
        get {
            
            if let _resolver = objc_getAssociatedObject(self, &AssociatedKeys.resolver) as? Resolver {
                return _resolver
            }
            
            if let coordinator = self as? Coordinator, let _resolver = coordinator.parentCoordinator?.resolver {
                return _resolver
            }
            
            return nil
            
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.resolver, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
