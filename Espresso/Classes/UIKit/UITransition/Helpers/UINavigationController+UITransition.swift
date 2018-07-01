//
//  UINavigationController+UITransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

public extension UINavigationController {
    
    /**
     Push a view controller onto the navigation stack using a specified transition & optional completion handler.
     
     - Parameter vc: The view controller to present.
     - Parameter transition: The transition to present the view controller with.
     */
    public func pushViewController(_ vc: UIViewController, with transition: UITransition) {
        
        vc.transition = transition
        self.delegate = vc.transition
        self.pushViewController(vc, animated: true)
        
    }
    
}
