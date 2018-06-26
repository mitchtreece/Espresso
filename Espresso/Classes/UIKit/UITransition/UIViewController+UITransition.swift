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
    
    @objc internal(set) var transition: UITransition? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.transition) as? UITransition
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.transition, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.transitioningDelegate = newValue
        }
    }
    
    public func present(_ vc: UIViewController, with transition: UITransition, completion: (()->(Void))?) {
        
        vc.transition = transition
        self.present(vc, animated: true, completion: completion)
        
    }
    
}
