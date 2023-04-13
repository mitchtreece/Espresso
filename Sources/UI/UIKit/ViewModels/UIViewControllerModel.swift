//
//  UIViewControllerModel.swift
//  Espresso
//
//  Created by Mitch Treece on 9/19/22.
//

import UIKit

/// Specialized base view-model class that manages a `UIViewController`.
///
/// This should never be used directly. Instead, create a specialized `UIViewControllerModel` by subclassing it.
open class UIViewControllerModel: ViewModel {
    
    /// The view model's managed view controller.
    public private(set) weak var viewController: UIViewController?
    
    /// The view model's managed view controller view.
    public var view: UIView? {
        return self.viewController?.view
    }

    /// Sets the view model's managed view controller.
    /// - parameter viewController: The view controller
    ///
    /// The view controller will only be set once. Subsequent calls to this function will be ignored.
    public func set(viewController: UIViewController) {
        
        guard self.viewController == nil else {
            
            // Cannot set the view model's
            // view controller more than once
            
            return
            
        }
        
        self.viewController = viewController
        
    }
    
}
