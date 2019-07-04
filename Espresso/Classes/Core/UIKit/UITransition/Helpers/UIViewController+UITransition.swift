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
    
    /**
     The view controller's transition object.
     */
    @objc var transition: UITransition? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.transition) as? UITransition
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.transition, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.transitioningDelegate = newValue
        }
    }
    
    /**
     Presents a view controller modally with a specified transition & optional completion handler.
     
     - Parameter vc: The view controller to present.
     - Parameter transition: The transition to present the view controller with.
     - Parameter completion: An optional completion block to run after the transition finishes.
     */
    func present(_ vc: UIViewController, with transition: UITransition, completion: (()->(Void))?) {
        
        vc.transition = transition
        self.present(vc, animated: true, completion: completion)
        
    }
    
}
