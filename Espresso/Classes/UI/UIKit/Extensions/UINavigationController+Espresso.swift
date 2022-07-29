//
//  UINavigationController+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/9/19.
//

import UIKit

public extension UINavigationController /* Push */ {
    
    /// Sets the navigation controller's view controllers with a given completion handler.
    /// - parameter viewControllers: The view controllers.
    /// - parameter completion: The completion handler to call after the view controllers have been set.
    ///
    /// This is always performed with animations.
    func setViewControllers(_ viewControllers: [UIViewController],
                            completion: @escaping ()->()) {
        
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
    
    /// Sets the navigation controller's view controllers.
    /// - parameter viewControllers: The view controllers.
    ///
    /// This is always performed with animations.
    func setViewControllers(_ viewControllers: [UIViewController]) async {
        
        await withCheckedContinuation { c in
            setViewControllers(viewControllers) {
                c.resume()
            }
        }
        
    }
    
    /// Push a view controller onto the navigation stack with a given completion handler.
    /// - parameter viewController: The view controller to push.
    /// - parameter completion: The completion handler to call after the view controller has been pushed.
    ///
    /// This is always performed with animations.
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
    
    /// Push a view controller onto the navigation stack.
    /// - parameter viewController: The view controller to push.
    ///
    /// This is always performed with animations.
    func pushViewController(_ viewController: UIViewController) async {
        
        await withCheckedContinuation { c in
            pushViewController(viewController) {
                c.resume()
            }
        }
        
    }
    
    /// Pop the top view controller off the navigation stack with a given completion handler.
    /// - parameter completion: The completion handler to call after popping.
    ///
    /// This is always performed with animations.
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
    
    /// Pop the top view controller off the navigation stack.
    /// - returns: The popped view controller.
    ///
    /// This is always performed with animations.
    func popViewController() async -> UIViewController? {
        
        await withCheckedContinuation { c in
            popViewController { viewController in
                c.resume(returning: viewController)
            }
        }
        
    }
    
    /// Pops all view controllers above the root off the navigation stack with a given completion handler.
    /// - parameter completion: The completion handler to call after popping.
    ///
    /// This is always performed with animations.
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
    
    /// Pops all view controllers above the root off the navigation stack.
    /// - returns: The popped view controllers.
    ///
    /// This is always performed with animations.
    func popToRootViewController() async -> [UIViewController]? {
        
        await withCheckedContinuation { c in
            popToRootViewController { viewControllers in
                c.resume(returning: viewControllers)
            }
        }
        
    }
    
    /// Pops to a view controller lower in the navigation stack with a given completion handler.
    /// - parameter completion: The completion handler to call after popping.
    ///
    /// This is always performed with animations.
    func popToViewController(_ viewController: UIViewController,
                             completion: @escaping ([UIViewController]?)->()) {
        
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
    
    /// Pops to a view controller lower in the navigation stack.
    /// - returns: The popped view controllers.
    ///
    /// This is always performed with animations.
    func popToViewController(_ viewController: UIViewController) async -> [UIViewController]? {
        
        await withCheckedContinuation { c in
            popToViewController(viewController) { viewControllers in
                c.resume(returning: viewControllers)
            }
        }
        
    }
    
}
