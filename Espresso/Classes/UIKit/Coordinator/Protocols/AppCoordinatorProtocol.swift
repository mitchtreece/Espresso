//
//  AppCoordinatorProtocol.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import UIKit

/**
 Protocol describing the attributes of an application coordinator.
 */
public protocol AppCoordinatorProtocol: BaseCoordinatorProtocol {
    
    /// The app coordinator's managed window.
    var window: UIWindow { get }
    
    /**
     Initializes an app coordinator with a window.
     - Parameter window: The app coordinator's managed window.
     - Parameter debug: A flag indicating if coordinator debug logging is enabled.
     */
    init(window: UIWindow, debug: Bool)
    
    /**
     Fetches the app coordinator's initial child coordinator.
     This function should be overriden by subclasses to return an appropriate child coordinator.
     - Returns: A `Coordinator` subclass.
     */
    func initialCoordinator() -> Coordinator
    
    /**
     Starts the app coordinator.
     - Returns: This app coordinator instance.
     */
    func start() -> Self
    
}
