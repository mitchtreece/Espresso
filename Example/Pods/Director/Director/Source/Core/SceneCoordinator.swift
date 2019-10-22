//
//  SceneCoordinator.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

/**
 A scene coordinator base class.
 
 ```
 class ExampleSceneCoordinator: SceneCoordinator {
 
    override func build() -> ViewCoordinator {
        return RootCoordinator()
    }
 
 }
 ```
 */
open class SceneCoordinator: AnyCoordinator {
    
    internal weak var director: SceneDirector!
    
    private var window: UIWindow {
        return self.director.window
    }
    
    private var navigationController: UINavigationController {
        return self.director.navigationController
    }
    
    public private(set) var rootCoordinator: ViewCoordinator!
    
    /// The scene coordinator's top-most child view cordinator,
    /// or the root view coordinator if no children have been started.
    ///
    /// This ignores embedded child view coordinator.
    public var topCoordinator: ViewCoordinator {
        return topCoordinator(in: self.rootCoordinator)
    }
    
    // MARK: Public
    
    public init() {
        //
    }
    
    /// Builds the scene coordinator's root view coordinator.
    /// This should be overriden by subclasses to return a custom view coordinator.
    ///
    /// This should **never** be called directly.
    ///
    /// - Returns: A `ViewCoordinator` instance.
    open func build() -> ViewCoordinator {
        fatalError("SceneCoordinator must return an initial view coordinator")
    }
    
    /// Removes all children from the scene coordinator's root view coordinator.
    ///
    /// - Parameter animated: Flag indicating if this should be done with an animation; _defaults to true_.
    /// - Parameter completion: An optional completion handler to call after all child view coordinators are removed; _defaults to nil_.
    public final func finishToRoot(animated: Bool = true, completion: (()->())? = nil) {
        
        replaceRootWithRoot(
            animated: animated,
            completion: completion
        )
        
    }
    
    // MARK: Private
    
    private func topCoordinator(in base: ViewCoordinator) -> ViewCoordinator {
        
        guard let lastManagedChild = base.children
            .filter({ !$0.isEmbedded })
            .last else { return base }
        
        return topCoordinator(in: lastManagedChild)
        
    }
    
    internal func buildForDirector() -> ViewCoordinator {
        
        let coordinator = build()
        self.rootCoordinator = coordinator
        return coordinator
        
    }
    
    internal func replaceRoot(with coordinator: ViewCoordinator, animated: Bool, completion: (()->())?) {
        
        guard let viewController = UIViewController.root(in: coordinator.build()) else {
            fatalError("SceneCoordinator failed to load replacement coordinator's root view controller")
        }
        
        debugLog("\(self.typeString) -(replace)-> \(self.rootCoordinator.typeString) -(with)-> \(coordinator.typeString)")
        
        coordinator.parentCoordinator = self
        coordinator.navigationController = self.navigationController
        self.rootCoordinator = coordinator
        
        guard animated else {
            
            self.navigationController.setViewControllers([viewController], animated: false)
            self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
            self.rootCoordinator.didStart()
            
            return
            
        }
        
        if let transitioningDelegate = viewController.transitioningDelegate,
            let transitioningNavDelegate = transitioningDelegate as? UINavigationControllerDelegate {
            
            self.navigationController.delegate = transitioningNavDelegate
            
            self.navigationController.pushViewController(viewController, animated: true, completion: {
                self.navigationController.setViewControllers([viewController], animated: false)
                self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
            })
            
            self.rootCoordinator.didStart()
            
        }
        else {
            
            self.navigationController.setViewControllers([viewController], animated: true)
            self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
            self.rootCoordinator.didStart()
            
        }
        
    }
    
    internal func replaceRootWithRoot(animated: Bool, completion: (()->())?) {
        
        self.rootCoordinator.children.forEach { $0.removeForParentReplacement() }
        
        let viewController = self.rootCoordinator.rootViewController!
        
        guard animated else {
            
            self.navigationController.setViewControllers([viewController], animated: false)
            self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
            completion?()
            
            return
            
        }
        
        if let transitioningDelegate = viewController.transitioningDelegate,
            let transitioningNavDelegate = transitioningDelegate as? UINavigationControllerDelegate {
            
            self.navigationController.delegate = transitioningNavDelegate
            
            self.navigationController.pushViewController(viewController, animated: true, completion: {
                self.navigationController.setViewControllers([viewController], animated: false)
                self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
                completion?()
            })
            
        }
        else {

            self.navigationController.setViewControllers([viewController], animated: true, completion: {
                self.rootCoordinator.navigationController.delegate = self.rootCoordinator.presentationDelegate
                completion?()
            })
            
        }
        
    }
    
}
