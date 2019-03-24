//
//  Coordinator.swift
//  Espresso
//
//  Created by Mitch Treece on 1/8/19.
//  Copyright © 2019 Mitch Treece. All rights reserved.
//

import UIKit

/**
 A coordinator base class.
 
 A coordinator manages view controller display state & presentation. They're used to define an app's navigation flow in chunks;
 while keeping navigation logic separate from view & app logic.
 
 A coordinator should manage the navigation of _only_ what it's concerned with.
 Multiple coordinators can live in a single navigation stack, each managing a set of view controllers in the stack.
 Likewise, a coordinator can be associated with as many (or as few) view controllers as needed.
 
 ```
 class GreenCoordinator: Coordinator {
 
    override func load() -> UIViewController {
 
        let vc = GreenViewController()
        vc.delegate = self
        return vc
 
    }
 
 }
 
 extension GreenCoordinator: GreenViewControllerDelegate {
 
    func didTapDone(_ sender: UIButton) {
        self.finish()
    }
 
 }
 ```
 ```
 class RedCoordinator: Coordinator {
 
    override func load() -> UIViewController {
 
        let vc = RedViewController()
        vc.delegate = self
        return vc
 
    }
 
 }
 
 extension RedCoordinator: RedViewControllerDelegate {
 
    func didTapGreen(_ sender: UIButton) {
 
        let coordinator = GreenCoordinator(parentCoordinator: self)
        self.start(child: coordinator)
 
    }
 
 }
 ```
 */
open class Coordinator: CoordinatorBase, Equatable {

    public static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
    
    /// The coordinator's parent coordinator.
    internal weak var parentCoordinator: AnyCoordinatorBase?
    
    public internal(set) var navigationController: UINavigationController!
    
    /// The coordinator's root view controller.
    /// This is set during the startup process _after_ `load()` is called.
    public private(set) var rootViewController: UIViewController!
    
    internal var navigationDelegate: CoordinatorNavigationDelegate!
    
    /// Flag indicating if the coordinator is going to be manually embedded in it's parent; _defaults to false_.
    ///
    /// If this is `true`, the coordinator **will not** be automatically presented / dismissed.
    /// Embedded coordinators must manage their own presentation & dismissal.
    public private(set) var isEmbedded: Bool = false
    
    internal private(set) var children = [Coordinator]()
    
    /**
     Initializes a coordinator.
     */
    public required init() {
        self.navigationDelegate = CoordinatorNavigationDelegate(coordinator: self)
    }
    
    open func load() -> UIViewController {
        fatalError("\(self.typeString) must return a root view controller")
    }
    
    internal func loadForAppCoordinator() -> UIViewController {
        
        self.rootViewController = load()
        return self.rootViewController
        
    }
    
    public func start(child coordinator: Coordinator, embedded: Bool = false) {
        
        // Set properties from parent -> child
        
        coordinator.parentCoordinator = self
        coordinator.navigationController = self.navigationController
        coordinator.navigationController.delegate = coordinator.navigationDelegate
        coordinator.isEmbedded = embedded
        
        // Set child's root view controller
        
        let rootViewController = coordinator.load()
        coordinator.rootViewController = rootViewController
        
        // Determine child's navigation controller
        
        if let nav = rootViewController as? UINavigationController, coordinator.isEmbedded {
            
            // If child is embedded & it's root is a nav controller,
            // Then it's nav controller should be its own; not its parents
            
            coordinator.navigationController = nav
            
        }
        
        add(child: coordinator)
        
        guard !coordinator.isEmbedded else {
            
            // If embedded, we should skip presentation logic.
            // Just call didStart(), and return
            
            coordinator.didStart()
            return
            
        }
        
        if let childNav = rootViewController as? UINavigationController {
            
            // Child coordinator is always created with parent's nav controller
            // If the child's root view controller is a nav controller, then we're
            // presenting modally and it's nav controller is it's own
            
            coordinator.navigationController = childNav
            presentModal(viewController: childNav)
            
        }
        else {
            
            self.navigationController.pushViewController(rootViewController, animated: true)
            
        }
        
        coordinator.didStart()
        
    }
    
    /**
     Called after the coordinator has been started & added to it's parent.
     Override this function to perform additional setup after the coordinator has been started.
     */
    open func didStart() {
        // Override me
    }
    
    /**
     Called after the coordinator has finished & removed from it's parent.
     Override this function to perform additional cleanup logic before the coordinator gets deallocated.
     */
    open func didFinish() {
        // Override me
    }
    
    public func replace(with coordinator: Coordinator, animated: Bool = true) {
        
        if let appCoordinator = self.parentCoordinator as? AppCoordinator {
            appCoordinator.replaceRootCoordinator(with: coordinator, animated: animated)
        }
        else {
            
            // TODO: Animations?
            
            let parent = self.parentCoordinator as! Coordinator
            coordinator.parentCoordinator = parent
            parent.start(child: coordinator)
            
            finish()
            
        }
        
    }
    
    public func finish() {
        
        if let _ = self.parentCoordinator as? AppCoordinator {
            self.debugPrint("Attempting to call finish on the application's root coordinator (\(self.typeString)). Skipping.")
            return
        }
        
        (self.parentCoordinator as! Coordinator)
            .remove(child: self)
        
        self.didFinish()
        
    }
    
    private func add(child: Coordinator) {

        guard !self.children.contains(child) else { return }
        debugPrint("\(self.typeString) =(add)=> \(child.typeString)")
        self.children.append(child)
        
    }
    
    internal func remove(child: Coordinator, dismiss: Bool = true) {
        
        guard let index = self.children.firstIndex(where: { $0 === child }) else { return }
        
        debugPrint("\(self.typeString) =(remove)=> \(child.typeString)")
        self.children.remove(at: index)
        
        guard !child.isEmbedded else { return }
        self.navigationController.delegate = self.navigationDelegate
        guard dismiss else { return }
        
        if child.rootViewController is UINavigationController {
            child.rootViewController.dismiss(animated: true, completion: nil)
        }
        else if let nav = child.rootViewController.navigationController, nav == self.navigationController {
            
            guard let rootVC = child.rootViewController else { return }
            guard let index = nav.viewControllers.index(of: rootVC) else { return }
            let destinationViewController = nav.viewControllers[index - 1]
            nav.popToViewController(destinationViewController, animated: true)
            
        }
        
    }
    
}
