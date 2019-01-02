//
//  BaseCoordinatorProtocol.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import UIKit

private struct AssociatedKeys {
    static var children: UInt8 = 0
}

/**
 Protocol describing the base attributes of a coordinator.
 */
public protocol BaseCoordinatorProtocol: class {
    
    /// The coordinator's root view controller.
    var rootViewController: UIViewController { get }
    
    /// The coordinator's parent.
    var parent: BaseCoordinatorProtocol? { get }
    
}

extension BaseCoordinatorProtocol /* App Coordinator */ {
    
    internal var appCoordinator: AppCoordinator {
        return _appCoordinator(in: self)
    }
    
    private func _appCoordinator(in baseCoordinator: BaseCoordinatorProtocol) -> AppCoordinator {
        
        if let coordinator = baseCoordinator as? AppCoordinator {
            return coordinator
        }
        
        guard let parent = self.parent else {
            fatalError("A coordinated application must contain exactly one AppCoordinator instance!")
        }
        
        return _appCoordinator(in: parent)
        
    }
    
}

extension BaseCoordinatorProtocol /* Debug */ {
    
    internal func debugLog(_ message: String) {
        
        guard self.appCoordinator.isDebugEnabled else { return }
        print("🎬 \(message)")
        
    }
    
    internal var typeString: String {
        return String(describing: type(of: self))
    }
    
}

extension BaseCoordinatorProtocol /* Child Management */ {
    
    /// The coordinator's child coordinators.
    internal(set) var children: [Coordinator] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.children) as? [Coordinator] ?? []
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.children, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /**
     Adds & starts a child coordinator.
     - parameter child: The child coordinator.
     - Parameter options: An optional start options dictionary.
     - parameter style: The style to present the child coordinator with; _defaults to push_.
     - parameter animated: Flag indicating if the child coordinator should start animated; _defaults to true_.
     */
    public func add(child coordinator: Coordinator,
                    options: [String: Any]? = nil,
                    style: Coordinator.PresentationStyle = .push,
                    animated: Bool = true) {
        
        if let options = options {
            
            if options.count > 1 {
                
                debugLog("\(self.typeString) --> adding child --> \(coordinator.typeString), options: [")
                
                for (key, value) in options {
                    print("\t\"\(key)\": \(value),")
                }
                
                print("], style: \(style)")
                
            }
            else {
                debugLog("\(self.typeString) --> adding child --> \(coordinator.typeString), options: \(options), style: \(style)")
            }
            
        }
        else {
            debugLog("\(self.typeString) --> adding child --> \(coordinator.typeString), style: \(style)")
        }
        
        let viewControllerToPresent = coordinator.start(options: options)
        let childViewController = self.childViewController(in: viewControllerToPresent)
        
        coordinator.presentationStyle = style
        coordinator.initialViewController = childViewController
        setViewControllerNavigationDelegate(viewControllerToPresent, with: coordinator)
        setCoordinatorIfNeeded(coordinator, on: childViewController)
        
        self.children.append(coordinator)
        self.present(viewController: viewControllerToPresent, style: style, animated: animated)
        
    }
    
    internal func remove(child coordinator: Coordinator, dismiss: Bool = true) {
        
        guard let index = self.children.firstIndex(where: { $0 === coordinator }) else { return }
        
        debugLog("\(self.typeString) --> removing child --> \(coordinator.typeString)")
        
        self.children.remove(at: index)
        
        if let _self = self as? Coordinator {
            setViewControllerNavigationDelegate(nil, with: _self)
        }
        
        guard dismiss else { return }
        
        switch coordinator.presentationStyle! {
        case .modal: coordinator.initialViewController.dismiss(animated: true, completion: nil)
        case .push:
            
            guard let initialViewController = coordinator.initialViewController, let nav = initialViewController.navigationController else { return }
            guard let index = nav.viewControllers.index(of: initialViewController) else { return }
            let toViewController = nav.viewControllers[index - 1]
            nav.popToViewController(toViewController, animated: true)
            
        }
        
    }
    
    private func setViewControllerNavigationDelegate(_ viewController: UIViewController?, with coordinator: Coordinator) {
        
        if let nav = self.topNavigationController /*, coordinator.startContext == .push */ {
            nav.delegate = coordinator.navigationDelegate
        }
        else {
            
            // An initial vc is either a nav controller, or it's not. It's never a vc embedded in a nav controller
            // let nav = (initialViewController as? UINavigationController) ?? initialViewController.navigationController
            
            (viewController as? UINavigationController)?.delegate = coordinator.navigationDelegate
            
        }
        
    }
    
    private func setCoordinatorIfNeeded(_ coordinator: BaseCoordinatorProtocol?, on viewController: UIViewController) {
        
        guard let coordinator = coordinator as? Coordinator else { return }
        guard var coordinating = viewController as? UIViewControllerCoordinating,
            coordinating._coordinator == nil else { return }
        
        coordinating._coordinator = coordinator
        
    }
    
}

extension BaseCoordinatorProtocol /* Navigation */ {
    
    private var topViewController: UIViewController? {
        
        let baseViewController = self.parent?.rootViewController ?? self.rootViewController
        return UIApplication.shared.keyViewController(in: baseViewController)
        
    }
    
    private var topNavigationController: UINavigationController? {
        return (self.topViewController as? UINavigationController) ?? self.topViewController?.navigationController
    }
    
    private func childViewController(in viewController: UIViewController) -> UIViewController {
        
        if let nav = viewController as? UINavigationController, let firstViewController = nav.viewControllers.first {
            return firstViewController
        }
        
        return viewController
        
    }
    
    /**
     Presents a view controller by either pushing it onto the parent coordinator's navigation stack, or presenting it modally.
     
     If `context` is set to _push_, and the view controller to be presented is a `UINavigationController` type,
     the navigation controller's `rootViewController` will be pushed onto the parent's navigation stack.
     Pushing a `UINavigationController` onto another navigation stack is not supported by the system.
     
     Likewise, if `context` is set to _push_, but the parent coordinator does _not_ contain a navigation controller,
     the view controller will be presented modally.
     
     - parameter viewController: The view controller to navigate to.
     - parameter context: The style to present the view controller with; _defaults to push_.
     - parameter animated: Flag indicating if the view controller should be presented with animations; _defaults to true_.
     */
    public func present(viewController: UIViewController,
                        style: Coordinator.PresentationStyle = .push,
                        animated: Bool = true) {
        
        if let nav = self.topNavigationController, style == .push {
            
            var viewControllerToPush = viewController
            
            if self.childViewController(in: viewController) != viewController {
                viewControllerToPush = self.childViewController(in: viewController)
            }
            
            setCoordinatorIfNeeded(self, on: viewControllerToPush)
            nav.pushViewController(viewControllerToPush, animated: animated)
            
            return
            
        }
        
        let parentViewController = self.topNavigationController ?? self.topViewController
        let childViewController = self.childViewController(in: viewController)
        
        setCoordinatorIfNeeded(self.parent, on: childViewController)
        parentViewController?.present(viewController, animated: animated, completion: nil)
        
    }
    
}
