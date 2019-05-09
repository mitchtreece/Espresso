//
//  AppCoordinator.swift
//  Espresso
//
//  Created by Mitch Treece on 1/8/19.
//  Copyright © 2019 Mitch Treece. All rights reserved.
//

import UIKit

/**
 An application coordinator base class.
 
 An app coordinator is created in the `AppDelegate`, and manages properties related to the application's window & initial view presentation.
 You should never use this class directly, `AppCoordinator` **must** be subclassed.
 
 ```
 class MyAppCoordinator: AppCoordinator {
 
    override func load() -> Coordinator {
        return MyInitialCoordinator()
    }
 
 }
 ```
 ```
 @UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate, CoordinatedApplication {
 
    var window: UIWindow?
    private var appCoordinator: MyAppCoordinator!
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 
        self.appCoordinator = self.coordinated(
            by: MyAppCoordinator.self
        ).start()
 
        return true
 
    }
 
 }
 ```
 */
open class AppCoordinator: AppCoordinatorBase {    
    
    /// The app coordinator's managed window.
    public private(set) var window: UIWindow
    
    /// Flag indicating if debug logging is enabled.
    public private(set) var isDebugEnabled: Bool

    /// The app coordinator's current root coordinator.
    public private(set) var rootCoordinator: Coordinator!
    
    /// The top-most child coordinator, _or_ the root coordinator
    /// if no children have been added.
    public var activeCoordinator: Coordinator {
        return self.rootCoordinator.children.last ?? self.rootCoordinator
    }
    
    public var navigationController: UINavigationController! {
        
        guard let nav = self.window.rootViewController as? UINavigationController else {
            fatalError("\(self.typeString)'s managed window must contain a root navigation controller")
        }
        
        return nav
        
    }
    
    required public init(window: UIWindow, debug: Bool) {

        self.window = window
        self.isDebugEnabled = debug

    }

    open func load() -> Coordinator {
        fatalError("\(self.typeString) must return a root coordinator")
    }

    public func start() -> Self {
        
        self.rootCoordinator = load()
        self.rootCoordinator.parentCoordinator = self

        if self.isDebugEnabled {
            print("🎬 \(self.typeString) =(add)=> \(self.rootCoordinator.typeString)")
        }
        
        guard let rootViewController = actualRootViewController(in: self.rootCoordinator.loadForAppCoordinator()) else {
            fatalError("\(self.rootCoordinator.typeString): unable to load a root view controller")
        }
        
        self.navigationController.setViewControllers([rootViewController], animated: false)
        self.rootCoordinator.navigationController = self.navigationController
        self.rootCoordinator.navigationController.delegate = self.rootCoordinator.navigationDelegate
        self.rootCoordinator.didStart()
        
        return self

    }
    
    internal func replaceRootCoordinator(with coordinator: Coordinator, animated: Bool) {
        
        if self.isDebugEnabled {
            print("🎬 \(self.typeString) =(replace)=> \(self.rootCoordinator.typeString) =(with)=> \(coordinator.typeString)")
        }
        
        coordinator.parentCoordinator = self
        self.rootCoordinator = coordinator
        self.rootCoordinator.navigationController = self.navigationController

        var viewController = coordinator.loadForAppCoordinator()
        if let nav = (viewController as? UINavigationController), let vc = nav.viewControllers.first {
            viewController = vc
        }
        
        if animated {
            
            if let transitioningDelegate = viewController.transitioningDelegate,
                let transitioningNavDelegate = transitioningDelegate as? UINavigationControllerDelegate {
                    self.navigationController.delegate = transitioningNavDelegate
                }
            
            self.navigationController.pushViewController(viewController, completion: {
                
                self.navigationController.setViewControllers([viewController], animated: false)
                self.rootCoordinator.navigationController.delegate = self.rootCoordinator.navigationDelegate
                self.rootCoordinator.didStart()
                
            })
            
        }
        else {
            
            self.navigationController.setViewControllers([viewController], animated: false)
            self.rootCoordinator.navigationController.delegate = self.rootCoordinator.navigationDelegate
            self.rootCoordinator.didStart()
            
        }
        
    }
    
    private func actualRootViewController(in viewController: UIViewController) -> UIViewController? {
        
        if let nav = viewController as? UINavigationController {
            return nav.viewControllers.first
        }
        
        return viewController
        
    }
    
}
