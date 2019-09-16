//
//  SceneDirector+DI.swift
//  Director
//
//  Created by Mitch Treece on 7/6/19.
//

import Swinject

public extension SceneDirector /* DI */ {
    
    /**
     Starts the scene director with a dependency resolver.
     
     - Parameter resolver: The dependency resolver.
     - Returns: This scene director instance.
     */
    final func start(with resolver: Resolver) -> Self {
        DIStorage.shared.resolver = resolver
        return start()
    }
    
}
