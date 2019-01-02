//
//  AppCoordinated.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import UIKit

/**
 Protocol describing the attributes of a coordinated application.
 */
public protocol AppCoordinated: class {
    
    /// The application's window.
    var window: UIWindow? { get set }
    
}

extension AppCoordinated {
    
    var isCoordinatorDebuggingEnabled: Bool {
        return false
    }
    
    /**
     Fetches & configures an app coordinator.
     - Parameter coordinator: The `AppCoordinator` type to use.
     - Parameter initialViewController: An optional initial view controller to embed into the application's window.
     If no value is supplied, a new `UIViewController` instance will be used; _defaults to nil_.
     - Parameter debug: Flag indicating if coordinator debug loggin is enabled; _defaults to false_.
     
     ```
     var window: UIWindow?
     var coordinator: MyAppCoordinator!
     
     self.coordinator = self.coordinated(
        by: MyAppCoordinator.self
     ).start()
     ```
     */
    public func coordinated<A: AppCoordinator>(by coordinator: A.Type, initialViewController: UIViewController? = nil, debug: Bool = false) -> A {
        
        if self.window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        self.window!.rootViewController = initialViewController ?? UIViewController()
        self.window!.makeKeyAndVisible()
        
        return A(window: self.window!, debug: debug)
        
    }
    
}
