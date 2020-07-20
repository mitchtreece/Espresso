//
//  UINavigationController+Director.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

internal extension UINavigationController {
    
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
    
    func popToViewController(_ viewController: UIViewController,
                             animated: Bool,
                             completion: @escaping ([UIViewController]?)->()) {
        
        let poppedViewControllers = popToViewController(
            viewController,
            animated: animated
        )

        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion(poppedViewControllers)
            }
        }
        else {
            completion(poppedViewControllers)
        }
        
    }

    func setViewControllers(_ viewControllers: [UIViewController],
                            animated: Bool,
                            completion: @escaping ()->()) {
        
        setViewControllers(
            viewControllers,
            animated: animated
        )
        
        if let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        }
        else {
            completion()
        }
        
    }
    
}
