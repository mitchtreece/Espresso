//
//  AppDelegate.swift
//  Demo
//
//  Created by Mitch Treece on 4/14/23.
//

import UIKit
import Espresso
import EspressoUI

@main
class AppDelegate: UIResponder,
                   UIApplicationDelegate {
    
    var collection = TraitCollection()

    private var bag = CancellableBag()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Environment
                
        let env = Environment.current
        var envString = "☕️ application environment: \(env.longName)"
        
        if ProcessInfo.processInfo.isDebugSessionAttached {
            envString += " [debug]"
        }
        
        print(envString)
                
        // Appearance
        
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
        
        // Publishers
        
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
        
        // Done
        
        return true
                
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        return UISceneConfiguration(
            name: "Default Configuration",
            sessionRole: connectingSceneSession.role
        )
        
    }

    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
        // Called when the user discards a scene session.
        //
        // If any sessions were discarded while the application
        // was not running, this will be called shortly after
        // application:didFinishLaunchingWithOptions.
        //
        // Use this method to release any resources that were specific
        // to the discarded scenes, as they will not return.
        
    }

}
