//
//  AppDelegate.swift
//  Espresso
//
//  Created by mitchtreece on 12/15/2017.
//  Copyright (c) 2017 mitchtreece. All rights reserved.
//

import UIKit
import Espresso

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var navController: UINavigationController!
    
    private var bag = CancellableBag()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        self.window = self.window ?? UIWindow(frame: UIScreen.main.bounds)
        self.navController = UINavigationController(rootViewController: RootViewController(delegate: self))
        self.window!.rootViewController = self.navController
        self.window!.makeKeyAndVisible()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        UINavigationBar
            .appearance()
            .standardAppearance = appearance
        
        UINavigationBar
            .appearance()
            .scrollEdgeAppearance = appearance
        
        UINavigationBar
            .appearance()
            .compactAppearance = appearance
        
        application
            .publishers
            .didBecomeActivePublisher
            .sink { print("☕️ application did become active") }
            .store(in: &self.bag)
        
        application
            .publishers
            .willResignActivePublisher
            .sink { print("☕️ application did resign active") }
            .store(in: &self.bag)
                
        return true
        
    }
    
    func asyncGetString() async -> String {
        
        try! await Task.sleep(nanoseconds: 1000)
        return "Hello, world!"
        
    }
    
    func asyncGetStringThrowing() async throws -> String {
        
        try await Task.sleep(nanoseconds: 1000)
        return "Hello, world!"
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        // Sent when the application is about to move from active to inactive state.
        // This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message)
        // or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates.
        // Games should use this method to pause the game.
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough application state information to restore your application to
        // its current state in case it is terminated later. If your application supports
        // background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        // Called as part of the transition from the background to the inactive state;
        // here you can undo many of the changes made on entering the background.
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive.
        // If the application was previously in the background, optionally refresh the user interface.
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        // Called when the application is about to terminate. Save data if appropriate.
        // See also applicationDidEnterBackground:.
        
    }
    
    func alert(_ message: String) {
        
        let alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        self.window?.rootViewController?.present(
            alert,
            animated: true,
            completion: nil
        )
        
    }

}

extension AppDelegate: RootViewControllerDelegate {
    
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
        case .views:
            
            vc = SwiftUIViewsContentView().asHostingController()
            vc.title = "SwiftUI Views"
            
        case .hostingView: vc = SwiftUIHostingViewController()
        }
        
        self.navController.pushViewController(
            vc,
            animated: true
        )
        
    }
    
    func rootViewController(_ vc: RootViewController,
                            didSelectTransitionRow row: RootViewController.TransitionRow) {
            
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

extension AppDelegate: DetailViewControllerDelegate {
    
    func detailViewControllerDidTapDone(_ viewController: DetailViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
