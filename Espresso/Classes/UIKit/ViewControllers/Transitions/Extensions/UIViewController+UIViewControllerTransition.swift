//
//  UIViewController+UIViewControllerTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

public extension UIViewController {
    
    private struct AssociatedKey {
        static var transition = "UIViewController.transition"
    }
    
    /// The view controller's transition.
    ///
    /// Setting this to a non-`nil` value also sets the view controller's
    /// `modalPresentationStyle` to `fullScreen`. If the transition is
    /// backed by a `UIPresentationController`, the view controller's
    /// `modalPresentationStyle` will instead be set to `custom`.
    ///
    /// Setting this to a `nil` value sets the view controller's
    /// modal presentation style back to the system default.
    @objc var transition: UIViewControllerTransition? {
        get {
            
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.transition
            ) as? UIViewControllerTransition
            
        }
        set {
            
            objc_setAssociatedObject(
                self,
                &AssociatedKey.transition,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            
            self.transitioningDelegate = newValue
            
            if let transition = newValue {
                self.modalPresentationStyle = transition.modalPresentationStyle
            }
            else {
                
                // If explicitly setting the transition to `nil`,
                // we should return the view controller's `modalPresentationStyle`
                // back to the system default.

                if #available(iOS 13, *) {
                    self.modalPresentationStyle = .automatic
                }
                else {
                    self.modalPresentationStyle = .fullScreen
                }

            }
                        
        }
    }
    
    /// Presents a view controller using a transition.
    /// - parameter viewController: The view controller to present.
    /// - parameter transition: The view controller transition.
    /// - parameter completion: An optional completion closure to run after the transition finishes; _defaults to nil_.
    func present(_ viewController: UIViewController,
                 using transition: UIViewControllerTransition,
                 completion: (()->())? = nil) {
        
        viewController.transition = transition
        
        present(
            viewController,
            animated: true,
            completion: completion
        )
        
    }
    
}
