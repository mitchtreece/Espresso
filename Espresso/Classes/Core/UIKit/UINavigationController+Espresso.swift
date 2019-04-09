//
//  UINavigationController+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/9/19.
//

import UIKit

public extension UINavigationController /* Push */ {
    
    /**
     Push a view controller onto the navigation stack with a given completion handler.
     - Parameter viewController: The view controller to push.
     - Parameter completion: The completion handler to call after the view controller has been pushed.
     */
    public func pushViewController(_ viewController: UIViewController, completion: @escaping ()->()) {
        
        CATransaction.begin()
        self.pushViewController(viewController, animated: true)
        CATransaction.setCompletionBlock {
            completion()
        }
        CATransaction.commit()
        
    }
    
}
