//
//  AnyCoordinator.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import Foundation

/// Protocol describing the base attributes of a coordinator.
public protocol AnyCoordinator: class {
    //
}

public extension AnyCoordinator {
    
    /// The coordinator stack's root scene coordinator.
    var sceneCoordinator: SceneCoordinator {
        
        guard let sceneCoordinator = self.sceneCoordinator(in: self) else {
            fatalError("The coordinator hierarchy doesn't contain a SceneCoordinator. This shouldn't happen.")
        }
        
        return sceneCoordinator
        
    }
    
    private func sceneCoordinator(in base: AnyCoordinator) -> SceneCoordinator? {
        
        if let sceneCoordinator = base as? SceneCoordinator {
            return sceneCoordinator
        }
        else if let viewCoordinator = base as? ViewCoordinator,
            let parent = viewCoordinator.parentCoordinator {
            return sceneCoordinator(in: parent)
        }
        
        return nil
        
    }
    
}

internal extension AnyCoordinator {
    
    var typeString: String {
        return String(describing: type(of: self))
    }
    
    func debugLog(_ string: String) {
        
        guard self.sceneCoordinator.director.isDebugEnabled else { return }
        print("🎬 \(string)")
        
    }
    
}
