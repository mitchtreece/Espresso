//
//  UIViewController+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 2/16/19.
//

import UIKit

private struct AssociatedKeys {
    static var life: UInt8 = 0
}

public extension UIViewController /* Life */ {
    
    var life: UIViewControllerLife {
        
        if let life = objc_getAssociatedObject(self, &AssociatedKeys.life) as? UIViewControllerLife {
            return life
        }

        let life = UIViewControllerLife(viewController: self)

        objc_setAssociatedObject(
            self,
            &AssociatedKeys.life,
            life,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )

        return life
        
    }
    
}

public extension Identifiable where Self: UIViewController /* Storyboard */ {
    
    /**
     Initializes a new instance of the view controller from a storyboard.
     
     - Parameter name: The storyboard's name; _defaults to \"Main\"_.
     - Parameter identifier: The view controller's storyboard identifier. If no identifier is provided, the class name will be used; _defaults to nil_.
     - Returns: A typed storyboard-loaded view controller instance.
     */
    static func initFromStoryboard(named name: String = "Main", identifier: String? = nil) -> Self? {
        
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let identifier = identifier ?? self.identifier
        return storyboard.instantiateViewController(withIdentifier: identifier) as? Self
        
    }
    
}
