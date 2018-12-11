//
//  CoordinatedNavigationDelegate.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import UIKit

internal class CoordinatedNavigationDelegate: NSObject, UINavigationControllerDelegate {
    
    private weak var coordinator: Coordinator?
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let coordinator = self.coordinator else { return }
        
        // Grab from view controller and make sure it was popped
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        guard !navigationController.viewControllers.contains(fromViewController) else { return }
        
        // Are we popping the coordinator's initial view controller?
        
        guard fromViewController == coordinator.initialViewController else { return }
        
        // Remove self from parent without
        // attempting to dismiss the view controller
        
        coordinator.parent?.remove(child: coordinator, dismiss: false)
        
    }
    
}
