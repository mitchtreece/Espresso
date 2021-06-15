//
//  UINavigationController+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/9/19.
//

import UIKit

public extension UINavigationController /* Push */ {
    
    /// Set the navigation controller's view controllers with a given completion handler.
    /// - Parameter viewControllers: The view controllers.
    /// - Parameter completion: The completion handler to call after the view controllers have been set.
    func setViewControllers(_ viewControllers: [UIViewController], completion: @escaping ()->()) {
        
        setViewControllers(
            viewControllers,
            animated: true
        )
        
        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        }
        else {
            completion()
        }
        
    }
    
    /// Push a view controller onto the navigation stack with a given completion handler.
    /// - Parameter viewController: The view controller to push.
    /// - Parameter completion: The completion handler to call after the view controller has been pushed.
    func pushViewController(_ viewController: UIViewController, completion: @escaping ()->()) {
        
        pushViewController(
            viewController,
            animated: true
        )
        
        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        }
        else {
            completion()
        }
        
    }
    
    /// Pop the top view controller off the navigation stack with a given completion handler.
    /// - Parameter completion: The completion handler to call after popping.
    func popViewController(completion: @escaping (UIViewController?)->()) {
        
        let poppedViewController = popViewController(animated: true)
        
        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion(poppedViewController)
            }
        }
        else {
            completion(poppedViewController)
        }
        
    }
    
    /// Pops all view controllers above the root off the navigation stack with a given completion handler.
    /// - Parameter completion: The completion handler to call after popping.
    func popToRootViewController(completion: @escaping ([UIViewController]?)->()) {
        
        let poppedViewControllers = popToRootViewController(animated: true)
        
        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion(poppedViewControllers)
            }
        }
        else {
            completion(poppedViewControllers)
        }
        
    }
    
    /// Pop to a view controller lower in the navigation stack with a given completion handler.
    /// - Parameter completion: The completion handler to call after popping.
    func popToViewController(_ viewController: UIViewController, completion: @escaping ([UIViewController]?)->()) {
        
        let poppedViewControllers = popToViewController(
            viewController,
            animated: true
        )

        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion(poppedViewControllers)
            }
        }
        else {
            completion(poppedViewControllers)
        }
        
    }
    
}
