//
//  SceneDelegate.swift
//  Demo
//
//  Created by Mitch Treece on 4/14/23.
//

import UIKit

class SceneDelegate: UIResponder,
                     UIWindowSceneDelegate {

    var window: UIWindow?
    private var navController: UINavigationController!

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        // Use this method to optionally configure and attach
        // the UIWindow `window` to the provided UIWindowScene `scene`.
        //
        // If using a storyboard, the `window` property will automatically
        // be initialized and attached to the scene.
        //
        // This delegate does not imply the connecting scene or session
        // are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
                    
        self.navController = UINavigationController(
            rootViewController: RootViewController(delegate: self)
        )
        
        self.window = self.window ?? UIWindow(windowScene: windowScene)
        self.window!.rootViewController = self.navController
        self.window!.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
        // Called as the scene is being released by the system.
        //
        // This occurs shortly after the scene enters the background,
        // or when its session is discarded.
        //
        // Release any resources associated with this scene that can
        // be re-created the next time the scene connects.
        //
        // The scene may re-connect later, as its session was not necessarily
        // discarded (see `application:didDiscardSceneSessions` instead).
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
        // Called when the scene has moved from an inactive
        // state to an active state.
        //
        // Use this method to restart any tasks that were paused
        // (or not yet started) when the scene was inactive.
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
        // Called as the scene transitions from the foreground to the background.
        //
        // Use this method to save data, release shared resources,
        // and store enough scene-specific state information to restore
        // the scene back to its current state.
        
    }
    
}

extension SceneDelegate: RootViewControllerDelegate {
    
    func rootViewController(_ vc: RootViewController,
                            didSelectUIKitRow row: RootViewController.UIKitRow) {
                
        var vc: UIViewController!
        
        switch row {
        case .views: vc = UIKitViewsViewController()
        }
                        
        self.navController.pushViewController(
            vc,
            animated: true
        )

    }
    
    func rootViewController(_ vc: RootViewController,
                            didSelectSwiftUIRow row: RootViewController.SwiftUIRow) {
        
        var vc: UIViewController!
        
        switch row {
//        case .views:
//
//            vc = SwiftUIViewsContentView().asHostingController()
//            vc.title = "SwiftUI Views"
//
        case .hostingView:
            
            vc = SwiftUIHostingViewController()
            
        }
        
        self.navController.pushViewController(
            vc,
            animated: true
        )
        
    }
    
    func rootViewController(_ vc: RootViewController,
                            didSelectTransitionRow row: RootViewController.VCTransitionRow) {
            
        let vc = DetailViewController()
        vc.title = row.title
        vc.showsDismissButton = true
        vc.delegate = self
        
        let nav = UINavigationController(rootViewController: vc)
        nav.transition = row.transition
        
        self.navController.present(
            nav,
            animated: true,
            completion: nil
        )
        
    }

    func rootViewControllerWantsToPresentCombineViewController(_ vc: RootViewController) {
             
        self.navController.pushViewController(
            CombineViewController(viewModel: CombineViewModel()),
            animated: true
        )
        
    }
    
}

extension SceneDelegate: DetailViewControllerDelegate {
    
    func detailViewControllerDidTapDone(_ viewController: DetailViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
