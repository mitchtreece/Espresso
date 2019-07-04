//
//  SceneDirector+DI.swift
//  Espresso
//
//  Created by Mitch Treece on 3/9/19.
//

import Director
import Swinject

public extension SceneDirector /* DI */ {
    
    /**
     Starts the scene director with a given dependency resolver.
     
     - Parameter resolver: The dependency resolver.
     - Returns: This scene director instance.
     */
    func start(with resolver: Resolver) -> Self {
        self.sceneCoordinator._resolver = resolver
        return start()
    }
    
}
