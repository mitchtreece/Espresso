//
//  UIViewController+UITransition.swift
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
    /// modal presentation style to `fullScreen`, _or_ to the transition's
    /// modal presentation style override if non-`nil`.
    ///
    /// Setting this to a `nil` value sets the view controller's
    /// modal presentation style back to the system default.
    @objc var transition: UITransition? {
        get {
            
            return objc_getAssociatedObject(
                self,
                &AssociatedKey.transition
            ) as? UITransition
            
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
                
                if let _ = transition as? UIPresentationTransition {
                    self.modalPresentationStyle = .custom
                }
                else {
                    self.modalPresentationStyle = transition.modalPresentationStyleOverride ?? .fullScreen
                }
                
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
    
    /**
     Presents a view controller modally with a transition & optional completion handler.
     
     - Parameter vc: The view controller to present.
     - Parameter transition: The transition to present the view controller with.
     - Parameter completion: An optional completion block to run after the transition finishes.
     */
    func present(_ vc: UIViewController, with transition: UITransition, completion: (()->())?) {
        
        vc.transition = transition
        
        self.present(
            vc,
            animated: true,
            completion: completion
        )
        
    }
    
}
