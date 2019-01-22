//
//  CoordinatedApplication.swift
//  Espresso
//
//  Created by Mitch Treece on 1/8/19.
//  Copyright © 2019 Mitch Treece. All rights reserved.
//

import UIKit

/**
 Protocol describing the attributes of a coordinated application.
 */
public protocol CoordinatedApplication: class {
    
    /// The application's window.
    var window: UIWindow? { get set }
    
}

extension CoordinatedApplication {
    
    /**
     Fetches & configures an app coordinator.
     - Parameter coordinator: The `AppCoordinator` type to use.
     - Parameter navigationController: An optional initial navigation controller to embed into the application's window.
     If no value is supplied, a new `UINavigationController` instance will be used; _defaults to nil_.
     - Parameter debug: Flag indicating if coordinator debug loggin is enabled; _defaults to false_.
     
     ```
     var window: UIWindow?
     var coordinator: MyAppCoordinator!
     
     self.coordinator = self.coordinated(
        by: MyAppCoordinator.self
     ).start()
     ```
     */
    public func coordinated<A: AppCoordinator>(by coordinator: A.Type,
                                               navigationController: UINavigationController? = nil,
                                               debug: Bool = false) -> A {
        
        if self.window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        self.window!.rootViewController = navigationController ?? UINavigationController()
        self.window!.makeKeyAndVisible()
        
        return A(window: self.window!, debug: debug)
        
    }
    
}
