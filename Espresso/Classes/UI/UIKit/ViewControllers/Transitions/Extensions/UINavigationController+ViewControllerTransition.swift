//
//  UINavigationController+ViewControllerTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

public extension UINavigationController {
    
    /// Push a view controller onto the navigation stack using a transition.
    ///
    /// - parameter viewController: The view controller to push.
    /// - parameter transition: The view controller transition.
    /// - parameter completion: An optional completion closure to run after the transition finishes; _defaults to nil_.
    ///
    /// This is always performed with animations.
    func pushViewController(_ viewController: UIViewController,
                            using transition: ViewControllerTransition,
                            completion: (()->())? = nil) {
        
        viewController.transition = transition
        
        let oldDelegate = self.delegate
        self.delegate = viewController.transition
        
        pushViewController(viewController) {
            self.delegate = oldDelegate
        }
                
    }
    
    /// Push a view controller onto the navigation stack using a transition.
    ///
    /// - parameter viewController: The view controller to push.
    /// - parameter transition: The view controller transition.
    ///
    /// This is always performed with animations.
    func pushViewController(_ viewController: UIViewController,
                            using transition: ViewControllerTransition) async {
        
        await withCheckedContinuation { c in
            pushViewController(viewController, using: transition) {
                c.resume()
            }
        }
        
    }
    
}
