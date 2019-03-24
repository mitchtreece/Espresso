//
//  AppCoordinator+DI.swift
//  Espresso
//
//  Created by Mitch Treece on 3/9/19.
//

import Swinject

public extension AppCoordinator /* DI */ {
    
    /**
     Starts the app coordinator with a given dependency resolver.
     
     - Parameter resolver: The dependency resolver.
     - Returns: This app coordinator instance.
     */
    public func start(with resolver: Resolver) -> Self {
        self._resolver = resolver
        return start()
    }
    
}
