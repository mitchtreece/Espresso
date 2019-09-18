//
//  UIApplicationLifecycle.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import UIKit

public class UIApplicationLife {
    
    public let didBecomeActive      = ObservableVoidEvent()
    public let willResignActive     = ObservableVoidEvent()
    public let didEnterBackground   = ObservableVoidEvent()
    public let willEnterForeground  = ObservableVoidEvent()
    public let willTerminate        = ObservableVoidEvent()

    private var observers = [Any]()
    
    deinit {
        
        self.observers.forEach { NotificationCenter.default.removeObserver($0) }
        self.observers.removeAll()
        
    }
    
    internal init() {
        
        let center = NotificationCenter.default
        let app = UIApplication.shared
        
        observers.append(center.addObserver(
            forName: UIApplication.didBecomeActiveNotification,
            object: app,
            queue: .main
        ) { [weak self] _ in
            self?.didBecomeActive.dispatch()
        })
        
        observers.append(center.addObserver(
            forName: UIApplication.willResignActiveNotification,
            object: app,
            queue: .main
        ) { [weak self] _ in
            self?.willResignActive.dispatch()
        })
        
        observers.append(center.addObserver(
            forName: UIApplication.didEnterBackgroundNotification,
            object: app,
            queue: .main
        ) { [weak self] _ in
            self?.didEnterBackground.dispatch()
        })
        
        observers.append(center.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: app,
            queue: .main
        ) { [weak self] _ in
            self?.willEnterForeground.dispatch()
        })
        
        observers.append(center.addObserver(
            forName: UIApplication.willTerminateNotification,
            object: app,
            queue: .main
        ) { [weak self] _ in
            self?.willTerminate.dispatch()
        })
        
    }
    
}
