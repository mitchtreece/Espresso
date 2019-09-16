//
//  SceneDirector.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

/**
 An application scene director.
 
 A scene director is created in an application's `AppDelegate` or `SceneDelegate`, depending on the target OS version.
 It manages properties related to the scene's window & initial view coordinator presentation.
 
 ```
 @UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {
 
    var window: UIWindow?
    private var director: SceneDirector!
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
 
        self.window = UIWindow(frame: UIScreen.main.bounds)
 
        self.director = SceneDirector(
            ExampleSceneCoordinator(),
            window: self.window!
        ).start()
 
    }
 
 }
 ```
 ```
 class SceneDelegate: UIResponder, UIWindowSceneDelegate {
 
    var window: UIWindow?
    private var director: SceneDirector!
 
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
        guard let windowScene = scene as? UIWindowScene else { return }
 
        self.window = UIWindow(windowScene: windowScene)
 
        self.director = Director(
            ExampleSceneCoordinator(),
            window: self.window!
        ).start()
 
    }
 
 }
 ```
 */
public final class SceneDirector {
    
    internal private(set) var window: UIWindow
    public private(set) var sceneCoordinator: SceneCoordinator
    
    internal var isDebugEnabled: Bool
    
    /// The scene director's managed navigation controller.
    public var navigationController: UINavigationController {
        
        if let nav = self.window.rootViewController as? UINavigationController {
            return nav
        }
        
        fatalError("Director's managed window must have a navigation controller at its root")
        
    }

    /// Initializes a scene director with a scene coordinator & window.
    /// - Parameter coordinator: The scene director's root scene coordinator.
    /// - Parameter window: The scene director's managed window.
    /// - Parameter debug: Flag indicating if debug logging is enabled; _defaults to false_.
    public init(_ coordinator: SceneCoordinator, window: UIWindow, debug: Bool = false) {
        
        self.isDebugEnabled = debug
        
        self.window = window
        self.window.rootViewController = self.window.rootViewController ?? UINavigationController()
        
        if !self.window.isKeyWindow {
            self.window.makeKeyAndVisible()
        }
        
        self.sceneCoordinator = coordinator
        self.sceneCoordinator.director = self
        
        UIViewController.director_swizzle()
        
    }
    
    /// Starts the scene director.
    /// - Returns: This scene director instance.
    public final func start() -> Self {
        
        let coordinator = self.sceneCoordinator.buildForDirector()
        coordinator.parentCoordinator = self.sceneCoordinator
        
        let viewController = coordinator.build()
        viewController.viewCoordinatorPresentationDelegate = coordinator.presentationDelegate
        coordinator.rootViewController = viewController
        
        guard let rootViewController = UIViewController.root(in: viewController) else {
            fatalError("Director failed to load the scene coordinator's initial child view controller")
        }
        
        if self.isDebugEnabled {
            print("🎬 SceneDirector -(start)-> \(self.sceneCoordinator.typeString)")
            print("🎬 \(self.sceneCoordinator.typeString) -(add)-> \(coordinator.typeString)")
        }
        
        self.navigationController.setViewControllers([rootViewController], animated: false)
        coordinator.navigationController = self.navigationController
        coordinator.navigationController.delegate = coordinator.presentationDelegate
        coordinator.didStart()
        
        return self
        
    }
    
}
