//
//  AnyCoordinatorBase.swift
//  Espresso
//
//  Created by Mitch Treece on 1/8/19.
//  Copyright © 2019 Mitch Treece. All rights reserved.
//

import UIKit

/**
 Protocol describing the base attributes of a coordinator.
 */
public protocol AnyCoordinatorBase: class {
    
    /// The coordinator's navigation controller.
    var navigationController: UINavigationController! { get }
    
}

extension AnyCoordinatorBase /* Debug */ {
    
    internal var typeString: String {
        return String(describing: type(of: self))
    }
    
}
