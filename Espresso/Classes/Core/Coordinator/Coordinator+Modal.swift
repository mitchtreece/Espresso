//
//  Coordinator+Modal.swift
//  Espresso
//
//  Created by Mitch Treece on 1/9/19.
//  Copyright © 2019 Mitch Treece. All rights reserved.
//

import UIKit

extension Coordinator /* Modal */ {
    
    private var viewControllerForModalPresentation: UIViewController? {
        return activeViewController(in: self.navigationController)
    }
    
    private func activeViewController(in base: UIViewController?) -> UIViewController? {
        
        if let presentedViewController = base?.presentedViewController {
            return activeViewController(in: presentedViewController)
        }
        else if let nav = base as? UINavigationController, let visibleViewController = nav.visibleViewController {
            return activeViewController(in: visibleViewController)
        }
        else if let tab = base as? UITabBarController, let selectedViewController = tab.selectedViewController {
            return activeViewController(in: selectedViewController)
        }
        
        return base
        
    }
    
    /**
     Presents a view controller modally from the navigation controller's key view controller.
     - Parameter viewController: The view controller to present.
     - Parameter animated: Flag indicating if the modal presentation should be performed with an animation; _defaults to true_.
     - Parameter completion: An optional completion handler to be called when the presentation finishes.
     */
    public func presentModal(viewController: UIViewController, animated: Bool = true, completion: (()->())? = nil) {
        
        self.viewControllerForModalPresentation?.present(
            viewController,
            animated: animated,
            completion: completion
        )
        
    }
    
}
