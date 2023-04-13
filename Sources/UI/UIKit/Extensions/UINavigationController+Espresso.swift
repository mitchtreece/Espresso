//
//  UINavigationController+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/9/19.
//

import UIKit

public extension UINavigationController /* Push */ {
    
    /// Sets the navigation controller's view controllers.
    ///
    /// - parameter viewControllers: The view controllers.
    /// - parameter animated: Flag indicating if the operation should be performed with an animation.
    /// - parameter completion: The completion handler to call after the view controllers have been set.
    func setViewControllers(_ viewControllers: [UIViewController],
                            animated: Bool,
                            completion: (()->())?) {
        
        setViewControllers(
            viewControllers,
            animated: animated
        )
        
        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                self.viewControllers = viewControllers
                completion?()
            }
        }
        else {
            self.viewControllers = viewControllers
            completion?()
        }
        
    }

    /// Sets the navigation controller's view controllers.
    ///
    /// - parameter viewControllers: The view controllers.
    /// - parameter animated: Flag indicating if the operation should be performed with an animation.
    func setViewControllers(_ viewControllers: [UIViewController],
                            animated: Bool) async {
        
        await withCheckedContinuation { c in
            
            setViewControllers(viewControllers,
                               animated: animated) {
                c.resume()
            }
            
        }
        
    }
    
    /// Pushes a view controller onto the navigation stack.
    ///
    /// - parameter viewController: The view controller to push.
    /// - parameter animated: Flag indicating if the push should be animated.
    /// - parameter completion: The completion handler to call after the view controller has been pushed.
    func pushViewController(_ viewController: UIViewController,
                            animated: Bool,
                            completion: (()->())?) {

        pushViewController(
            viewController,
            animated: animated
        )
        
        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        }
        else {
            completion?()
        }
        
    }
    
    /// Pushes a view controller onto the navigation stack.
    ///
    /// - parameter viewController: The view controller to push.
    func pushViewController(_ viewController: UIViewController,
                            animated: Bool) async {
        
        await withCheckedContinuation { c in
            
            pushViewController(viewController,
                               animated: animated) {
                c.resume()
            }
            
        }
        
    }
    
    /// Pops the top view controller off the navigation stack.
    ///
    /// - parameter animated: Flag indicating if the pop should be animated.
    /// - parameter completion: The completion handler to call after the view controller has been popped.
    func popViewController(animated: Bool,
                           completion: (()->())?) {
        
        popViewController(animated: animated)
        
        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        }
        else {
            completion?()
        }
        
    }

    /// Pops the top view controller off the navigation stack.
    func popViewController(animated: Bool) async {
        
        await withCheckedContinuation { c in
            popViewController(animated: animated) {
                c.resume()
            }
        }
        
    }
    
    /// Pops all view controllers above the root off the navigation stack.
    ///
    /// - parameter animated: Flag indicating if the pop should be animated.
    /// - parameter completion: The completion handler to call after popping.
    func popToRootViewController(animated: Bool,
                                 completion: (()->())?) {
        
        popToRootViewController(animated: animated)

        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        }
        else {
            completion?()
        }
        
    }

    /// Pops all view controllers above the root off the navigation stack.
    ///
    /// - parameter animated: Flag indicating if the pop should be animated.
    func popToRootViewController(animated: Bool) async {
        
        await withCheckedContinuation { c in
            popToRootViewController(animated: animated) {
                c.resume()
            }
        }
        
    }
    
    /// Pops to a view controller lower in the navigation stack.
    ///
    /// - parameter animated: Flag indicating if the pop should be animated.
    /// - parameter completion: The completion handler to call after popping.
    func popToViewController(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (()->())?) {
        
        popToViewController(
            viewController,
            animated: animated
        )
        
        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion?()
            }
        }
        else {
            completion?()
        }
        
    }

    /// Pops to a view controller lower in the navigation stack.
    ///
    /// - parameter viewController: The view controller to pop to.
    /// - parameter animated: Flag indicating if the pop should be animated.
    func popToViewController(_ viewController: UIViewController,
                             animated: Bool) async {
        
        await withCheckedContinuation { c in
            
            popToViewController(viewController,
                                animated: animated) {
                c.resume()
            }
            
        }
        
    }
    
}
