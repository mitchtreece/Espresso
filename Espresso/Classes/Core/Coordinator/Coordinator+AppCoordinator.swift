//
//  Coordinator+AppCoordinator.swift
//  Espresso
//
//  Created by Mitch Treece on 1/10/19.
//  Copyright © 2019 Mitch Treece. All rights reserved.
//

import UIKit

extension Coordinator /* AppCoordinator */ {
    
    internal var appCoordinator: AppCoordinator {
        
        guard let coordinator = self.appCoordinator(in: self) else {
            fatalError("Application's must contain exactly one AppCoordinator subclass")
        }
        
        return coordinator
        
    }
    
    private func appCoordinator(in coordinator: AnyCoordinatorBase?) -> AppCoordinator? {
        
        guard let coordinator = coordinator else { return nil }
        
        if let appCoordinator = coordinator as? AppCoordinator {
            return appCoordinator
        }
        
        guard let _coordinator = coordinator as? Coordinator else { return nil }
        return appCoordinator(in: _coordinator.parentCoordinator)
        
    }
    
}
