//
//  ViewCoordinator+Navigation.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

public extension ViewCoordinator /* Navigation */ {
    
    /// Pushes a view controller onto the view coordinator's navigation controller.
    /// - Parameter viewController: The view controller to push.
    /// - Parameter animated: Flag indicating if the presentation should be performed with an animation; _defaults to true_.
    /// - Parameter completion: An optional completion handler to call after the view controller has been pushed; _defaults to nil_.
    final func push(_ viewController: UIViewController,
              animated: Bool = true,
              completion: (()->())? = nil) {
        
        guard animated else {
            
            self.navigationController.pushViewController(
                viewController,
                animated: false
            )
            
            completion?()
            return
            
        }
        
        self.navigationController.pushViewController(
            viewController,
            animated: true,
            completion: completion
        )
        
    }
    
}
