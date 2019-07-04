//
//  UINavigationController+Director.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

internal extension UINavigationController {
    
    func pushViewController(_ viewController: UIViewController, completion: (()->())?) {
        
        CATransaction.begin()
        self.pushViewController(viewController, animated: true)
        CATransaction.setCompletionBlock {
            completion?()
        }
        CATransaction.commit()
        
    }
    
    func popToViewController(_ viewController: UIViewController, completion: @escaping ([UIViewController]?)->()) {
        
        CATransaction.begin()
        let poppedViewControllers = self.popToViewController(viewController, animated: true)
        CATransaction.setCompletionBlock {
            completion(poppedViewControllers)
        }
        CATransaction.commit()
        
    }

    func setViewControllers(_ viewControllers: [UIViewController], completion: @escaping ()->()) {
        
        CATransaction.begin()
        self.setViewControllers(viewControllers, animated: true)
        CATransaction.setCompletionBlock {
            completion()
        }
        CATransaction.commit()
        
    }
    
}
