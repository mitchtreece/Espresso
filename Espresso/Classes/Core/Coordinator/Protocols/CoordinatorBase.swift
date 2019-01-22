//
//  CoordinatorBase.swift
//  Espresso
//
//  Created by Mitch Treece on 1/8/19.
//  Copyright © 2019 Mitch Treece. All rights reserved.
//

import UIKit

/**
 Protocol describing the attributes of a coordinator.
 */
public protocol CoordinatorBase: AnyCoordinatorBase {
    
    /**
     Loads the coordinator's root view controller.
     Called by a parent coordinator while starting a child.
     This function should be overriden by subclasses to return an appropriate view controller.

     This should **never** be called directly.
     
     - Returns: A `UIViewController` instance.
     */
    func load() -> UIViewController
    
    /**
     Starts, adds, & presents a child coordinator.
     
     If the child coordinator is embedded, it will still be added to the child coordinator stack,
     but it **will not** be presented. An embedded coordinator manages it's own presentation / dismissal.
     
     - Parameter coordinator: The child coordinator.
     */
    func start(child coordinator: Coordinator)
    
    /**
     Tells the coordinator's parent that it's finished.
     This will remove the child from the parent's coordinator stack & dismiss it if needed.
     
     If the coordinator is embedded, it will still be removed from its parent's coordinator stack,
     but it **will not** be dismissed. An embedded coordinator manages it's own presentation / dismissal.
     */
    func finish()
    
}
