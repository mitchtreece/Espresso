//
//  AppDelegate.swift
//  Espresso
//
//  Created by mitchtreece on 12/15/2017.
//  Copyright (c) 2017 mitchtreece. All rights reserved.
//

import UIKit
import Espresso
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var navController: UINavigationController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        self.window = self.window ?? UIWindow(frame: UIScreen.main.bounds)
        self.navController = UINavigationController(rootViewController: RootViewController(delegate: self))
        self.window!.rootViewController = self.navController
        self.window!.makeKeyAndVisible()
        
        application.events.didBecomeActive.addObserver {
            print("☕️ application did become active")
        }
        
        application.events.willResignActive.addObserver {
            print("☕️ application will resign active")
        }
        
        return true
        
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
                            didSelectSwiftUIRow row: RootViewController.SwiftUIRow) {
                
        var vc: UIViewController!
        
        switch row {
        case .views: vc = UIHostingController(rootView: ViewsContentView())
        }
        
//        let nav = UINavigationController(rootViewController: vc)
                
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
    
    func rootViewController(_ vc: RootViewController,
                            didSelectMenuRow row: RootViewController.MenuRow) {
        
        if #available(iOS 13, *) {
            
            var vc: UIViewController
            
            switch row {
            case .view:
                
                vc = ContextMenuViewController()
                vc.title = row.title
                
            case .table:
                
                let contextTableVC = ContextMenuTableViewController()
                contextTableVC.title = row.title
                contextTableVC.delegate = self
                vc = contextTableVC
                
            case .collection:
                
                let contextCollectionVC = ContextMenuCollectionViewController()
                contextCollectionVC.title = row.title
                contextCollectionVC.delegate = self
                vc = contextCollectionVC
                
            }
            
            self.navController.pushViewController(
                vc,
                animated: true
            )
            
        }
        
    }
    
    func rootViewControllerWantsToPresentRxViewController(_ vc: RootViewController) {
        
        self.navController.pushViewController(
            RxViewController(viewModel: RxViewModel()),
            animated: true
        )
        
    }
    
    func rootViewControllerWantsToPresentCombineViewController(_ vc: RootViewController) {
     
        guard #available(iOS 13, *) else { return }
        
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

extension AppDelegate: ContextMenuTableViewControllerDelegate {
    
    func contextMenuTableViewController(_ vc: ContextMenuTableViewController,
                                        didSelectColor color: ESColor) {
        
        let vc = DetailViewController()
        vc.view.backgroundColor = color.color
        
        self.navController.pushViewController(
            vc,
            animated: true
        )
        
    }
    
}

extension AppDelegate: ContextMenuCollectionViewControllerDelegate {
    
    func contextMenuCollectionViewController(_ vc: ContextMenuCollectionViewController,
                                             didSelectColor color: ESColor) {
        
        let vc = DetailViewController()
        vc.view.backgroundColor = color.color
        
        self.navController.pushViewController(
            vc,
            animated: true
        )
        
    }
    
}
