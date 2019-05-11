//
//  UINavigationController+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/9/19.
//

import UIKit

public extension UINavigationController /* Push */ {
    
    /**
     Set the navigation controller's view controllers with a given completion handler.
     - Parameter viewControllers: The view controllers.
     - Parameter completion: The completion handler to call after the view controllers have been set.
     */
    func setViewControllers(_ viewControllers: [UIViewController], completion: @escaping ()->()) {
        
        CATransaction.begin()
        self.setViewControllers(viewControllers, animated: true)
        CATransaction.setCompletionBlock {
            completion()
        }
        CATransaction.commit()
        
    }
    
    /**
     Push a view controller onto the navigation stack with a given completion handler.
     - Parameter viewController: The view controller to push.
     - Parameter completion: The completion handler to call after the view controller has been pushed.
     */
    func pushViewController(_ viewController: UIViewController, completion: @escaping ()->()) {
        
        CATransaction.begin()
        self.pushViewController(viewController, animated: true)
        CATransaction.setCompletionBlock {
            completion()
        }
        CATransaction.commit()
        
    }
    
    /**
     Pop the top view controller off the navigation stack with a given completion handler.
     - Parameter completion: The completion handler to call after popping.
     */
    func popViewController(completion: @escaping (UIViewController?)->()) {
        
        CATransaction.begin()
        let poppedViewController = self.popViewController(animated: true)
        CATransaction.setCompletionBlock {
            completion(poppedViewController)
        }
        CATransaction.commit()
        
    }
    
    /**
     Pops all view controllers above the root off the navigation stack with a given completion handler.
     - Parameter completion: The completion handler to call after popping.
     */
    func popToRootViewController(completion: @escaping ([UIViewController]?)->()) {
        
        CATransaction.begin()
        let poppedViewControllers = self.popToRootViewController(animated: true)
        CATransaction.setCompletionBlock {
            completion(poppedViewControllers)
        }
        CATransaction.commit()
        
    }
    
    /**
     Pop to a view controller lower in the navigation stack with a given completion handler.
     - Parameter completion: The completion handler to call after popping.
     */
    func popToViewController(_ viewController: UIViewController, completion: @escaping ([UIViewController]?)->()) {
        
        CATransaction.begin()
        let poppedViewControllers = self.popToViewController(viewController, animated: true)
        CATransaction.setCompletionBlock {
            completion(poppedViewControllers)
        }
        CATransaction.commit()
        
    }
    
}
