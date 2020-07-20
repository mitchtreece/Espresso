//
//  ViewCoordinator.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

/**
 A view coordinator base class.
 
 View coordinator's manage view controller display state & presentation.
 They're used to define a scene's navigation flow in chunks;
 while keeping navigation & presentation logic separate from app & view logic.
 
 A view coordinator should manage the navigation of _only_ what it's concerned with.
 Multiple view coordinators can live in a single navigation stack, each managing a slice of view controllers in the stack.
 Likewise, a view coordinator can be associated with as many (or as few) view controllers as needed.
 
 ```
 class GreenCoordinator: ViewCoordinator {
 
    override func build() -> UIViewController {
 
        let vc = GreenViewController()
        vc.delegate = self
        return vc
 
    }
 
 }
 
 extension GreenCoordinator: GreenViewControllerDelegate {
 
    func didTapDone(_ sender: UIButton) {
        finish()
    }
 
 }
 ```
 ```
 class RedCoordinator: ViewCoordinator {
 
    override func build() -> UIViewController {
 
        let vc = RedViewController()
        vc.delegate = self
        return vc
 
    }
 
 }
 
 extension RedCoordinator: RedViewControllerDelegate {
 
    func didTapGreen(_ sender: UIButton) {
 
        let coordinator = GreenCoordinator()
        start(child: coordinator)
 
    }
 
 }
 ```
 */
open class ViewCoordinator: AnyCoordinator, Equatable {
    
    public static func == (lhs: ViewCoordinator, rhs: ViewCoordinator) -> Bool {
        return lhs === rhs
    }
    
    /// The view coordinator's parent coordinator.
    public internal(set) weak var parentCoordinator: AnyCoordinator?
    
    /// The view coordinator's root view controller.
    public internal(set) var rootViewController: UIViewController!
    
    /// The view coordinator's managed navigation controller.
    public internal(set) var navigationController: UINavigationController!
    
    internal var presentationDelegate: ViewCoordinatorPresentationDelegate!
    internal private(set) var children = [ViewCoordinator]()
    
    /// Flag indicating if the view coordinator is embedded in a parent view coordinator.
    private(set) var isEmbedded: Bool = false
    
    /// Flag indicating if the view coordinator has been started.
    private(set) var isStarted: Bool = false
    
    /// Flag indicating if the view coordinator has been finished.
    public internal(set) var isFinished: Bool = false
    
    // MARK: Public
    
    public required init() {
        self.presentationDelegate = ViewCoordinatorPresentationDelegate(coordinator: self)
    }
    
    /// Builds a view coordinator's root view controller.
    /// Called by a parent coordinator while starting a child.
    /// This should be overriden by subclasses to return a custom view controller.
    ///
    /// If a `UIViewController` instance is returned from this function, the parent coordinator
    /// will start & push onto it's existing navigation stack. However, if a `UINavigationController`
    /// instance is returned, the parent will treat this child as being self-managed, and present the
    /// returned navigation controller modally.
    ///
    /// This should **never** be called directly.
    ///
    /// - Returns: A `UIViewController` instance.
    open func build() -> UIViewController {
        fatalError("ViewCoordinator must return an initial view controller")
    }
    
    /// Called after the view coordinator has been started & added to it's parent coordinator.
    /// Override this function to perform additional setup if needed.
    open func didStart() {
        // Override me
    }
    
    /// Called when the view coordinator's managed navigation controller pops a view controller.
    /// Override this function to perform additional actions if needed.
    open func didPopViewController(_ viewController: UIViewController) {
        // Override me
    }
    
    /// Called after the view coordinator has been finished & removed from it's parent coordinator.
    /// Override this function to perform additional cleanup if needed.
    open func didFinish() {
        // Override me
    }
    
    /**
     Starts, adds, & presents a child coordinator.
     
     If the child coordinator is embedded, it will still be added to the child coordinator stack,
     but it **will not** be presented. An embedded coordinator manages it's own presentation / dismissal.
     
     - Parameter coordinator: The child coordinator.
     - Parameter animated: Flag indicating if the coordinator should start with an animation; _defaults to true_.
     - Parameter embedded: Flag indicating if the coordinator is going to be manually embedded in it's parent; _defaults to false_.
     */
    
    /// Starts & presents a child view coordinator.
    /// - Parameter: coordinator: The child view coordinator.
    /// - Parameter animated: Flag indicating if the view coordinator should be started with an animation; _defaults to true_.
    /// - Parameter completion: Optional completion handler to call after the child view coordinator has been started; _defaults to nil_.
    public final func start(child coordinator: ViewCoordinator, animated: Bool = true, completion: (()->())? = nil) {
        _start(child: coordinator, animated: animated, embedded: false, completion: completion)
    }
    
    /// Starts an embedded child view coordinator.
    ///
    /// The child view coordinator will still be added to the receiver's coordinator stack,
    /// but it **will not** be presented. Embedded view coordinators manage their own presentation & dismissal.
    ///
    /// - Parameter coordinator: The child view coordinator.
    public final func startEmbedded(child coordinator: ViewCoordinator) {
        _start(child: coordinator, animated: false, embedded: true, completion: nil)
    }
    
    /// Starts a collection of embedded child view coordinators.
    ///
    /// The child view coordinators will still be added to the receiver's coordinator stack,
    /// but they **will not** be presented. Embedded view coordinators manage their own presentation & dismissal.
    ///
    /// - Parameter children: The child view coordinators.
    public final func startEmbedded(children: [ViewCoordinator]) {
        children.forEach { self._start(child: $0, animated: false, embedded: true, completion: nil) }
    }
    
    private func _start(child coordinator: ViewCoordinator, animated: Bool, embedded: Bool, completion: (()->())?) {
        
        guard !coordinator.isStarted else { return }
        coordinator.isStarted = true
        
        // Set properties from parent -> child
        
        coordinator.parentCoordinator = self
        coordinator.navigationController = self.navigationController
        coordinator.navigationController.delegate = coordinator.presentationDelegate
        coordinator.isEmbedded = embedded
        
        // Set child's root view controller
        
        let viewController = coordinator.build()
        viewController.viewCoordinatorPresentationDelegate = coordinator.presentationDelegate
        coordinator.rootViewController = viewController
        
        // Determine child's navigation controller
        
        if let nav = viewController as? UINavigationController, embedded {
            
            // If child is embedded & it's root is a nav controller,
            // Then it's nav controller should be its own; not its parents
            
            coordinator.navigationController = nav
            
        }
        
        add(child: coordinator)
        
        guard !embedded else {
            
            // If embedded, we should skip presentation logic.
            // Just call didStart(), and return
            
            coordinator.didStart()
            completion?()
            return
            
        }
        
        if let nav = viewController as? UINavigationController {
            
            // Child coordinator is always created with parent's nav controller
            // If the child's root view controller is a nav controller, then we're
            // presenting modally and it's nav controller is it's own
            
            coordinator.navigationController = nav
            
            UIViewController.active(in: self.navigationController)?.present(
                nav,
                animated: animated,
                completion: {
                    completion?()
                    coordinator.didStart()
                })
            
        }
        else {
            
            guard animated else {
                
                self.navigationController.pushViewController(
                    viewController,
                    animated: false
                )
                
                coordinator.didStart()
                completion?()
                return
                
            }
            
            if let transitioningDelegate = viewController.transitioningDelegate,
                let transitioningNavDelegate = transitioningDelegate as? UINavigationControllerDelegate {
                
                let oldDelegate = self.navigationController.delegate
                self.navigationController.delegate = transitioningNavDelegate
                
                self.navigationController.pushViewController(viewController, animated: true, completion: {
                    self.navigationController.delegate = oldDelegate
                    coordinator.didStart()
                    completion?()
                })
                
                return
                
            }
            
            self.navigationController.pushViewController(
                viewController,
                animated: true,
                completion: {
                    coordinator.didStart()
                    completion?()
                })
            
        }
        
    }

    /// Replaces the view coordinator with another in the same parent coordinator.
    /// - Parameter coordinator: The replacement view coordinator.
    /// - Parameter animated: Flag indicating if the replacement should be done with an animation; _defaults to true_.
    /// - Parameter completion: Optional completion handler to call after the replacement has finished; _defaults to nil_.
    public final func replace(with coordinator: ViewCoordinator, animated: Bool = true, completion: (()->())? = nil) {
        
        guard !self.isEmbedded else { return }
        guard let parent = self.parentCoordinator else { return }
        
        self.children.forEach { $0.removeForParentReplacement() }
        
        if let sceneCoordinator = parent as? SceneCoordinator {

            sceneCoordinator.replaceRoot(
                with: coordinator,
                animated: animated,
                completion: completion
            )
            
        }
        else {
            
            let parentViewCoordinator = parent as! ViewCoordinator
            
            debugLog("\(parentViewCoordinator.typeString) -(replace)-> \(self.typeString), -(with)-> \(coordinator.typeString)")
            
            coordinator.parentCoordinator = self.parentCoordinator
            (self.parentCoordinator as! ViewCoordinator).start(
                child: coordinator,
                animated: animated,
                completion: {
                    self.finish(completion: completion)
                })
            
        }
        
    }
    
    /// Replaces the view coordinator's managed child view controllers with another set in the same navigation controller.
    /// - Parameter viewControllers: The replacement view controllers.
    /// - Parameter animated: Flag indicating if the replacement should be done with an animation; _defaults to true_.
    /// - Parameter completion: An optional completion handler to call after the replacement has finished; _defaults to nil_.
    public final func replaceChildViewControllers(with viewControllers: [UIViewController], animated: Bool = true, completion: (()->())? = nil) {
     
        guard !viewControllers.isEmpty else {
            debugLog("Cannot replace a view coordinator's managed child view controllers with an empty set; skipping.")
            return
        }
        
        let currentViewControllers = self.navigationController.viewControllers
        
        guard let rootViewControllerArrayIndex = currentViewControllers
            .firstIndex(of: self.rootViewController) else { return }
        
        // Assuming receiving coordinator is top-most.
        // This might not be the case as the end index might
        // not always be (vc count - 1).
        // Should handle this better.
        
        let startIndex = Int(rootViewControllerArrayIndex)
        var endIndex = (currentViewControllers.count - 1)
        
        if let firstChildRootViewController = self.children.first?.rootViewController {
            
            guard let endViewControllerArrayIndex = currentViewControllers
                .firstIndex(of: firstChildRootViewController) else { return }
            
            endIndex = Int(endViewControllerArrayIndex)
            
        }
        
        var replacementViewControllers = [UIViewController]()
        var replacementIndex: Int = 0
        
        for i in 0..<currentViewControllers.count {
            
            var vc = currentViewControllers[i]
            
            if (i >= startIndex) && (i <= endIndex) {
                vc = viewControllers[replacementIndex]
                replacementIndex += 1
            }
            
            replacementViewControllers.append(vc)
            
        }
        
        self.rootViewController = viewControllers.first!
        self.presentationDelegate.isEnabled = false
        
        self.navigationController.setViewControllers(
            replacementViewControllers,
            animated: animated,
            completion: {
                self.presentationDelegate.isEnabled = true
            })
        
    }
    
    /// Removes the view coordinator from its parent's coordinator stack,
    /// & dismisses it the same way it was presented.
    ///
    /// If the view coordinator is embedded, it will still be removed from its parent's coordinator stack,
    /// but it **will not** be dismissed. An embedded view coordinator manages its own presentation & dismissal.
    ///
    /// - Parameter completion: An optional completion handler to call after the view coordinator finishes; _defaults to nil_.
    public final func finish(completion: (()->())? = nil) {
        
        guard !self.isEmbedded else { return }
        guard !self.isFinished else { return }
        
        guard let parent = self.parentCoordinator as? ViewCoordinator else {
            debugLog("Cannot finish a SceneCoordinator's root coordinator. Skipping.")
            return
        }
        
        parent.remove(
            child: self,
            completion: {
                self.didFinish()
                completion?()
            })
        
    }
    
    // MARK: Private
    
    private func add(child coordinator: ViewCoordinator) {
        
        guard !self.children.contains(coordinator) else { return }
        debugLog("\(self.typeString) -(add)-> \(coordinator.typeString)")
        self.children.append(coordinator)
        
    }
    
    private func remove(child coordinator: ViewCoordinator,
                        fromNavigationPop: Bool = false,
                        forReplacement: Bool = false,
                        completion: (()->())? = nil) {
        
        guard !coordinator.isFinished else { return }
        guard let index = self.children.firstIndex(where: { $0 === coordinator }) else { return }
        
        // Finish child's children
        
        for child in coordinator.children {
            
            debugLog("\(coordinator.typeString) -(remove)-> \(child.typeString)")
            child.isFinished = true
            child.didFinish()
            
        }
        
        coordinator.children.removeAll()
        
        // Remove child
        
        debugLog("\(self.typeString) -(remove)-> \(coordinator.typeString)")
        coordinator.isFinished = true
        self.children.remove(at: index)
        
        // Dismiss if needed
        
        guard !forReplacement else { return }
        guard !coordinator.isEmbedded else { return }
        
        self.navigationController.delegate = self.presentationDelegate
        
        guard !fromNavigationPop else {
            completion?()
            return
        }
        
        if let nav = coordinator.rootViewController as? UINavigationController {
            
            nav.dismiss(
                animated: true,
                completion: completion
            )
            
        }
        else if let nav = coordinator.rootViewController.navigationController, nav == self.navigationController {
            
            guard let index = nav.viewControllers.firstIndex(of: coordinator.rootViewController) else { return }
            let destinationViewController = nav.viewControllers[index - 1]
            
            nav.popToViewController(
                destinationViewController,
                animated: true,
                completion: { _ in
                    completion?()
                })
            
        }
        
    }
    
    internal func removeForParentReplacement() {
        
        guard !self.isFinished else { return }
        
        self.children.forEach { $0.removeForParentReplacement() }
        
        (self.parentCoordinator as? ViewCoordinator)?.remove(
            child: self,
            forReplacement: true
        )
        
    }
    
    internal func removeForModalDismiss(child coordinator: ViewCoordinator) {
        remove(child: coordinator)
    }
    
    internal func removeForNavigationPop(child coordinator: ViewCoordinator) {
        
        remove(
            child: coordinator,
            fromNavigationPop: true
        )
        
    }
    
}
