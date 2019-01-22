//
//  AppCoordinatorBase.swift
//  Espresso
//
//  Created by Mitch Treece on 1/8/19.
//  Copyright © 2019 Mitch Treece. All rights reserved.
//

import UIKit

/**
 Protocol describing the attributes of an application coordinator.
 */
public protocol AppCoordinatorBase: AnyCoordinatorBase {
    
    /// The app coordinator's managed window.
    var window: UIWindow { get }
    
    /**
     Initializes an app coordinator with a window.
     - Parameter window: The app coordinator's managed window.
     - Parameter debug: A flag indicating if debug logging is enabled.
     */
    init(window: UIWindow, debug: Bool)

    /**
     Loads the app coordinator's root coordinator.
     This function should be overriden by subclasses to return an appropriate coordinator.
     
     This should **never** be called directly.
     
     - Returns: A `Coordinator` subclass.
     */
    func load() -> Coordinator
    
    /**
     Starts the app coordinator.
     - Returns: This app coordinator instance.
     */
    func start() -> Self
    
}
