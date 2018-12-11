//
//  AppCoordinator.swift
//  Espresso
//
//  Created by Mitch Treece on 12/7/18.
//

import UIKit

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
open class AppCoordinator: AppCoordinatorProtocol {
    
    public private(set) var window: UIWindow
    public private(set) var isDebugEnabled: Bool
    
    // MARK: BaseCoordinatorProtocol
    
    public var rootViewController: UIViewController {
        
        guard let rootViewController = self.window.rootViewController else {
            fatalError("AppCoordinator's window contains no root view controller")
        }
        
        return rootViewController
        
    }
    
    // This should always be nil ////////////////////////////////
    public private(set) weak var parent: BaseCoordinatorProtocol?
    /////////////////////////////////////////////////////////////
    
    // MARK: Public
    
    required public init(window: UIWindow, debug: Bool) {
        
        self.window = window
        self.isDebugEnabled = debug
        
    }
    
    open func initialCoordinator() -> Coordinator {
        fatalError("AppCoordinator's must return an initial child coordinator")
    }
    
    public func start() -> Self {
        
        self.add(
            child: initialCoordinator(),
            style: .modal,
            animated: false
        )
        
        return self
        
    }
    
}
