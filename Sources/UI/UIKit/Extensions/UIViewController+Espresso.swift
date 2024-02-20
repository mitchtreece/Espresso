//
//  UIViewController+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 2/16/19.
//

import UIKit

public extension UIViewController /* Modal */ {
    
    /// Presents a view controller modally, awaiting presentation completion.
    /// - parameter viewController: The view controller to present.
    ///
    /// This is always performed with animations.
    func present(_ viewController: UIViewController) async {
        
        await withCheckedContinuation { c in
            present(viewController, animated: true) {
                c.resume()
            }
        }
        
    }
    
    /// Dismisses the view controller that was presented modally by the
    /// view controller, awaiting dismissal completion.
    ///
    /// This is always performed with animations.
    func dismiss() async {
        
        await withCheckedContinuation { c in
            dismiss(animated: true) {
                c.resume()
            }
        }
        
    }
    
}

public extension UIViewController /* Top (Highest) */ {
    
    /// The highest (top-most) view controller in the hierarchy,
    /// starting from this view controller.
    var highestViewController: UIViewController? {
        
        return Self.highestPresented(
            from: self,
            current: self
        )
        
    }
    
    /// The highest (top-most) view controller in the hierarchy,
    /// starting from a given view controller.
    /// - returns: A view controller, or `nil`.
    static func highestViewController(from viewController: UIViewController) -> UIViewController? {
        
        return Self.highestPresented(
            from: viewController,
            current: viewController
        )
        
    }
    
    /// The highest (top-most) *presented* view controller in the hierarchy,
    /// starting from this view controller.
    var highestPresentedViewController: UIViewController? {
        
        return Self.highestPresented(
            from: self,
            current: nil
        )
        
    }
    
    /// The highest (top-most) *presented* view controller in the hierarchy,
    /// starting from a given view controller.
    /// - returns: A view controller, or `nil`.
    static func highestPresentedViewController(from viewController: UIViewController) -> UIViewController? {
        
        return Self.highestPresented(
            from: viewController,
            current: nil
        )
        
    }
    
    fileprivate static func highestPresented(from vc: UIViewController,
                                             current: UIViewController?) -> UIViewController? {
        
        guard let presented = vc.presentedViewController else {
            return current
        }
        
        return highestPresented(
            from: presented,
            current: presented
        )
        
    }
    
}

public extension UIViewController /* Lowest */ {
    
    /// The lowest (bottom-most) view controller in the hierarchy,
    /// starting from this view controller.
    var lowestViewController: UIViewController? {
        
        return Self.lowestPresenting(
            from: self,
            current: self
        )
        
    }
    
    /// The lowest (bottom-most) view controller in the hierarchy,
    /// starting from a given view controller.
    /// - returns: A view controller, or `nil`.
    static func lowestViewController(from viewController: UIViewController) -> UIViewController? {
        
        return Self.lowestPresenting(
            from: viewController,
            current: viewController
        )
        
    }
    
    /// The lowest (bottom-most) *presenting* view controller in the hierarchy,
    /// starting from this view controller.
    var lowestPresentingViewController: UIViewController? {
        
        return Self.lowestPresenting(
            from: self,
            current: nil
        )
        
    }
    
    /// The lowest (bottom-most) *presenting* view controller in the hierarchy,
    /// starting from a given view controller.
    /// - returns: A view controller, or `nil`.
    static func lowestPresentingViewController(from viewController: UIViewController) -> UIViewController? {
        
        return Self.lowestPresenting(
            from: viewController,
            current: nil
        )
        
    }
    
    fileprivate static func lowestPresenting(from vc: UIViewController,
                                             current: UIViewController?) -> UIViewController? {
        
        guard let presenting = vc.presentingViewController else {
            return current
        }
        
        return lowestPresenting(
            from: presenting,
            current: presenting
        )
        
    }
    
}

public extension UIViewController /* Navigation */ {
    
    /// Flag indicating if the view-controller is embedded in a `UINavigationController`
    /// stack **and** is not the stack's root view-controller.
    var isNavigationPoppable: Bool {

        if let nav = self.navigationController,
           nav.viewControllers.count > 1 { return true }

        return false
        
    }
    
}
