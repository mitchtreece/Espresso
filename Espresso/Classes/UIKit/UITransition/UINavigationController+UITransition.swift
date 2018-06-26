//
//  UINavigationController+UITransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

public extension UINavigationController {
    
    public func pushViewController(_ vc: UIViewController, with transition: UITransition) {
        
        vc.transition = transition
        self.delegate = vc.transition
        self.pushViewController(vc, animated: true)
        
    }
    
}
