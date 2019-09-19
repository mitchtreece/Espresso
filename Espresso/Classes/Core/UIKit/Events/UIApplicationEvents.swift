//
//  UIApplicationEvents.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import UIKit


public class UIApplicationEvents {
    
    public let didBecomeActive      = VoidEvent()
    public let willResignActive     = VoidEvent()
    public let didEnterBackground   = VoidEvent()
    public let willEnterForeground  = VoidEvent()
    public let willTerminate        = VoidEvent()
    
    public let protectedDataAvailabilityWillChange  = Event<Bool>()
    public let significantTimeChange                = VoidEvent()
    public let backgroundRefreshStatusDidChange     = VoidEvent()
    public let userDidTakeScreenshot                = VoidEvent()
    public let didReceiveMemoryWarning              = VoidEvent()
    
    // NOTE: These notifications were deprecated in iOS 13 in favor of
    // `viewWillTransitionToSize:withTransitionCoordinator:`.
    // Should probably remove these at some point.
    public let willChangeStatusBarOrientation   = VoidEvent()
    public let didChangeStatusBarOrientation    = VoidEvent()
    public let willChangeStatusBarFrame         = VoidEvent()
    public let didChangeStatusBarFrame          = VoidEvent()

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
            queue: .main,
            using: { [weak self] _ in
                self?.didBecomeActive.dispatch()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.willResignActiveNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.willResignActive.dispatch()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.didEnterBackgroundNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.didEnterBackground.dispatch()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.willEnterForeground.dispatch()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.willTerminateNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.willTerminate.dispatch()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.willChangeStatusBarOrientationNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.willChangeStatusBarOrientation.dispatch()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.didChangeStatusBarOrientationNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.didChangeStatusBarOrientation.dispatch()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.willChangeStatusBarFrameNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.willChangeStatusBarFrame.dispatch()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.didChangeStatusBarFrameNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.didChangeStatusBarFrame.dispatch()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.protectedDataWillBecomeUnavailableNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.protectedDataAvailabilityWillChange.dispatch(value: false)
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.protectedDataDidBecomeAvailableNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.protectedDataAvailabilityWillChange.dispatch(value: true)
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.significantTimeChangeNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.significantTimeChange.dispatch()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.backgroundRefreshStatusDidChangeNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.backgroundRefreshStatusDidChange.dispatch()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.userDidTakeScreenshotNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.userDidTakeScreenshot.dispatch()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.didReceiveMemoryWarningNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.didReceiveMemoryWarning.dispatch()
            }))
        
    }
    
}
