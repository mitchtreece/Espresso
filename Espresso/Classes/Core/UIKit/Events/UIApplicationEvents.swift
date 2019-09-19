//
//  UIApplicationEvents.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import UIKit

/// `UIApplication` event holder class.
public class UIApplicationEvents {
    
    /// Dispatched after the application becomes active.
    public let didBecomeActive = VoidEvent()
    
    /// Dispatched when the application will resign active.
    public let willResignActive = VoidEvent()
    
    /// Dispatched after the application did enter the background.
    public let didEnterBackground = VoidEvent()
    
    /// Dispatched when the application will enter the foreground.
    public let willEnterForeground = VoidEvent()
    
    /// Dispatched when the application will terminate.
    public let willTerminate = VoidEvent()
    
    /// Dispatched when protected data availibility will change.
    public let protectedDataAvailabilityWillChange = Event<Bool>()
    
    /// Dispatched after a significant time change occurs.
    public let significantTimeChange = VoidEvent()
    
    /// Dispatched after a background refresh status change occurs.
    public let backgroundRefreshStatusDidChange = VoidEvent()
    
    /// Dispatched after the user takes a screenshot.
    public let userDidTakeScreenshot = VoidEvent()
    
    /// Dispatched after the application receives a memory warning.
    public let didReceiveMemoryWarning = VoidEvent()
    
    // NOTE: These notifications were deprecated in iOS 13 in favor of
    // `viewWillTransitionToSize:withTransitionCoordinator:`.
    // Should probably remove these at some point.
    
    /// Dispatched when the application will change the status bar orientation.
    public let willChangeStatusBarOrientation = VoidEvent()
    
    /// Dispatched after the application changes the status bar orientation.
    public let didChangeStatusBarOrientation = VoidEvent()
    
    /// Dispatched when the application will change the status bar frame.
    public let willChangeStatusBarFrame = VoidEvent()
    
    /// Dispatched after the application changes the status bar frame.
    public let didChangeStatusBarFrame = VoidEvent()

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
