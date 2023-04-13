//
//  UINavigationController+UIViewControllerTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

public extension UINavigationController {
    
    /// Pushes a view controller onto the navigation stack using a transition.
    /// - parameter viewController: The view controller to push.
    /// - parameter transition: The view controller transition.
    /// - parameter completion: An optional completion closure to run after the transition finishes.
    func pushViewController(_ viewController: UIViewController,
                            using transition: UIViewControllerTransition,
                            completion: (()->())? = nil) {
        
        viewController.transition = transition
        
        let oldDelegate = self.delegate
        self.delegate = viewController.transition
        
        pushViewController(
            viewController,
            animated: true,
            completion: {
                self.delegate = oldDelegate
            })
              
    }
    
    /// Pushes a view controller onto the navigation stack using a transition.
    /// - parameter viewController: The view controller to push.
    /// - parameter transition: The view controller transition.
    func pushViewController(_ viewController: UIViewController,
                            using transition: UIViewControllerTransition) async {
        
        await withCheckedContinuation { c in
            pushViewController(viewController, using: transition) {
                c.resume()
            }
        }
        
    }
    
}
