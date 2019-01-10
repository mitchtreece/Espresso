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
        return keyViewController(in: self.navigationController)
    }
    
    private func keyViewController(in base: UIViewController?) -> UIViewController? {
        
        if let presentedViewController = base?.presentedViewController {
            return keyViewController(in: presentedViewController)
        }
        else if let nav = base as? UINavigationController, let visibleViewController = nav.visibleViewController {
            return keyViewController(in: visibleViewController)
        }
        else if let tab = base as? UITabBarController, let selectedViewController = tab.selectedViewController {
            return keyViewController(in: selectedViewController)
        }
        
        return base
        
    }
    
    /**
     Presents a view controller modally from the navigation controller's key view controller.
     - Parameter viewController: The view controller to present.
     */
    public func presentModal(viewController: UIViewController) {
        self.viewControllerForModalPresentation?.present(viewController, animated: true, completion: nil)
    }
    
}
