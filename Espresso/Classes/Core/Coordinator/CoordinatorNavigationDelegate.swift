//
//  CoordinatorNavigationDelegate.swift
//  Espresso
//
//  Created by Mitch Treece on 1/9/19.
//  Copyright © 2019 Mitch Treece. All rights reserved.
//

import UIKit

internal class CoordinatorNavigationDelegate: NSObject, UINavigationControllerDelegate {
    
    private weak var coordinator: Coordinator?
    
    internal init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let coordinator = self.coordinator else { return }
        
        // Grab source view controller and make sure it was popped
        
        guard let sourceViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        guard !navigationController.viewControllers.contains(sourceViewController) else { return }
        
        // Are we popping the coordinator's initial view controller?
        
        guard sourceViewController == coordinator.rootViewController else { return }
        
        // Remove self from parent without attempting to dismiss the view controller
        
        (coordinator.parentCoordinator as? Coordinator)?
            .remove(child: coordinator, dismiss: false)
        
    }
    
}
