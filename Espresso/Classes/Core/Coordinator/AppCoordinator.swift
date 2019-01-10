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
 
    override func initialCoordinator() -> Coordinator {
        return MyInitialCoordinator.in(parent: self)
    }
 
 }
 ```
 ```
 @UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate, AppCoordinated {
 
    var window: UIWindow?
    var coordinator: MyAppCoordinator!
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 
        self.coordinator = self.coordinated(
            by: MyAppCoordinator.self
        ).start()
 
        return true
 
    }
 
 }
 ```
 */
open class AppCoordinator: AppCoordinatorBase {    
    
    public private(set) var window: UIWindow
    
    /// Flag indicating if debug logging is enabled.
    public private(set) var isDebugEnabled: Bool

    private var rootCoordinator: Coordinator!
    
    public var navigationController: UINavigationController {
        
        guard let nav = self.window.rootViewController as? UINavigationController else {
            fatalError("AppCoordinator managed window must contain a root navigation controller")
        }
        
        return nav
        
    }
    
    required public init(window: UIWindow, debug: Bool) {

        self.window = window
        self.isDebugEnabled = debug

    }

    open func load() -> Coordinator {
        fatalError("AppCoordinator must return a root coordinator")
    }

    public func start() -> Self {

        self.rootCoordinator = load()
        let rootViewController = self.rootCoordinator.load()
        
        guard !(rootViewController is UINavigationController) else {
            fatalError("An AppCoordinator's root view controller cannot be a UINavigationController")
        }
        
        self.navigationController.setViewControllers([rootViewController], animated: false)
        
        return self

    }
    
}
