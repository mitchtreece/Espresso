//
//  CoordinatorProtocol.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import UIKit

/**
 Protocol describing the attributes of a coordinator.
 */
public protocol CoordinatorProtocol: BaseCoordinatorProtocol {
    
    /**
     Initializes a coordinator with a root view controller & parent coordinator.
     
     This initializer **should not** be overridden _or_ used directly.
     Use `Coordinator.in(parent:)` instead.
     
     - Parameter rootViewController: The root view controller.
     - Parameter parent: The parent coordinator.
     */
    init(rootViewController: UIViewController, parent: BaseCoordinatorProtocol)
    
    /**
     Called by a parent coordinator while starting a child coordinator.
     This function should return the coordintor's starting view controller.
     - Parameter options: An optional start options dictionary.
     - Returns: A `UIViewController` instance.
     */
    func start(options: [String: Any]?) -> UIViewController
    
}
