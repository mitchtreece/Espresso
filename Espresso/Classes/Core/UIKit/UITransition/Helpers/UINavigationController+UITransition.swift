//
//  UINavigationController+UITransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

public extension UINavigationController {
    
    /**
     Push a view controller onto the navigation stack using a transition.
     
     - Parameter vc: The view controller to present.
     - Parameter transition: The transition to present the view controller with.
     */
    func pushViewController(_ vc: UIViewController, with transition: UITransition?) {
        
        guard let transition = transition else {
            
            self.pushViewController(
                vc,
                animated: true
            )
            
            return
            
        }
        
        vc.transition = transition
        
        let oldDelegate = self.delegate
        self.delegate = vc.transition
        
        self.pushViewController(
            vc,
            animated: true
        )
        
        self.delegate = oldDelegate
        
    }
    
}
