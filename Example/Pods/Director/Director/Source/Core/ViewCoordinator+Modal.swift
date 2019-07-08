//
//  ViewCoordinator+Modal.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

public extension ViewCoordinator /* Modal */ {
    
    /// Presents a view controller modally from the view coordinator's navigation controller.
    /// - Parameter viewController: The view controller to present.
    /// - Parameter animated: Flag indicating if the presentation should be performed with an animation; _defaults to true_.
    /// - Parameter completion: An optional completion handler to call after the modal presentation finishes; _defaults to nil_.
    final func modal(_ viewController: UIViewController,
               animated: Bool = true,
               completion: (()->())? = nil) {
        
        self.navigationController.present(
            viewController,
            animated: animated,
            completion: completion
        )
        
    }
    
}
