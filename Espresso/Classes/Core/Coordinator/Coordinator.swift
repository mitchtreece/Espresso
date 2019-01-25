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
    internal private(set) weak var parentCoordinator: AnyCoordinatorBase?
    
    public private(set) var navigationController: UINavigationController
    
    /// The coordinator's root view controller.
    /// This is set during the startup process _after_ `load()` is called.
    public private(set) var rootViewController: UIViewController!
    
    internal var navigationDelegate: CoordinatorNavigationDelegate!
    
    /// Flag indicating if the coordinator is going to be manually embedded in it's parent; _defaults to false_.
    ///
    /// If this is `true`, the coordinator **will not** be automatically presented / dismissed.
    /// Embedded coordinators must manage their own presentation & dismissal.
    public var isEmbedded: Bool = false
    
    private var children = [Coordinator]()
    
    deinit {
        
        // Don't call `debugPrint(_ message:)` here as it relies on `parentCoordinator`.
        // The `parentCoordinator` property will be `nil` when `deinit` is called.
        // print("🎬 \(self.typeString) destroyed <--- DISABLE THIS PRINT BEFORE RELEASE")
        
    }
    
    /**
     Initializes a new coordinator in a parent coordinator.
     - Parameter parent: The coordinator's parent coordinator.
     - Parameter embedded: Flag indicating if the coordinator is going to be manually embedded in it's parent; _defaults to false_.
     */
    public required init(in parent: AnyCoordinatorBase, embedded: Bool = false) {
        
        self.parentCoordinator = parent
        self.navigationController = parent.navigationController
        
        self.navigationDelegate = CoordinatorNavigationDelegate(coordinator: self)
        self.navigationController.delegate = self.navigationDelegate
        
    }
    
    open func load() -> UIViewController {
        fatalError("Coordinator must return a root view controller")
    }
    
    internal func loadForAppCoordinator() -> UIViewController {
        
        self.rootViewController = load()
        return self.rootViewController
        
    }
    
    public func start(child coordinator: Coordinator) {
        
        let rootViewController = coordinator.load()
        coordinator.rootViewController = rootViewController
        
        if let nav = rootViewController as? UINavigationController, coordinator.isEmbedded {
            
            // If child is embedded & it's root is a nav controller,
            // Then it's nav controller should be its own; not its parents
            
            coordinator.navigationController = nav
            
        }
        
        add(child: coordinator)
        
        guard !coordinator.isEmbedded else {
            coordinator.didStart()
            return
        }
        
        if let childNav = rootViewController as? UINavigationController {
            
            // Coordinator is always created with parent's nav controller
            // If coordinator's rootVC is a nav controller, then we're
            // presenting modally and it's nav controller is it's own
            
            coordinator.navigationController = childNav
            presentModal(viewController: childNav)
            
        } else {
            
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
    
    public func finish() {
        (self.parentCoordinator as? Coordinator)?.remove(child: self)
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
