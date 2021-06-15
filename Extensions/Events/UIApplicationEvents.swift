//
//  UIApplicationEvents.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import UIKit

/// `UIApplication` event holder class.
public class UIApplicationEvents {
    
    /// Emitted after the application becomes active.
    public let didBecomeActive = VoidEvent()
    
    /// Emitted when the application will resign active.
    public let willResignActive = VoidEvent()
    
    /// Emitted after the application did enter the background.
    public let didEnterBackground = VoidEvent()
    
    /// Emitted when the application will enter the foreground.
    public let willEnterForeground = VoidEvent()
    
    /// Emitted when the application will terminate.
    public let willTerminate = VoidEvent()
    
    /// Emitted when protected data availibility will change.
    public let protectedDataAvailabilityWillChange = Event<Bool>()
    
    /// Emitted after a significant time change occurs.
    public let significantTimeChange = VoidEvent()
    
    /// Emitted after a background refresh status change occurs.
    public let backgroundRefreshStatusDidChange = VoidEvent()
    
    /// Emitted after the user takes a screenshot.
    public let userDidTakeScreenshot = VoidEvent()
    
    /// Emitted after the application receives a memory warning.
    public let didReceiveMemoryWarning = VoidEvent()
    
    /// Emitted when the application will change the status bar orientation.
    @available(iOS, deprecated: 13.0, message: "Use `UIViewController.viewWillTransitionToSize(size:coordinator:)`")
    public let willChangeStatusBarOrientation = VoidEvent()
    
    /// Emitted after the application changes the status bar orientation.
    @available(iOS, deprecated: 13.0, message: "Use `UIViewController.viewWillTransitionToSize(size:coordinator:)`")
    public let didChangeStatusBarOrientation = VoidEvent()
    
    /// Emitted when the application will change the status bar frame.
    @available(iOS, deprecated: 13.0, message: "Use `UIViewController.viewWillTransitionToSize(size:coordinator:)`")
    public let willChangeStatusBarFrame = VoidEvent()
    
    /// Emitted after the application changes the status bar frame.
    @available(iOS, deprecated: 13.0, message: "Use `UIViewController.viewWillTransitionToSize(size:coordinator:)`")
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
                self?.didBecomeActive.emit()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.willResignActiveNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.willResignActive.emit()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.didEnterBackgroundNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.didEnterBackground.emit()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.willEnterForeground.emit()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.willTerminateNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.willTerminate.emit()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.willChangeStatusBarOrientationNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.willChangeStatusBarOrientation.emit()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.didChangeStatusBarOrientationNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.didChangeStatusBarOrientation.emit()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.willChangeStatusBarFrameNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.willChangeStatusBarFrame.emit()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.didChangeStatusBarFrameNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.didChangeStatusBarFrame.emit()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.protectedDataWillBecomeUnavailableNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.protectedDataAvailabilityWillChange.emit(value: false)
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.protectedDataDidBecomeAvailableNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.protectedDataAvailabilityWillChange.emit(value: true)
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.significantTimeChangeNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.significantTimeChange.emit()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.backgroundRefreshStatusDidChangeNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.backgroundRefreshStatusDidChange.emit()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.userDidTakeScreenshotNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.userDidTakeScreenshot.emit()
            }))
        
        observers.append(center.addObserver(
            forName: UIApplication.didReceiveMemoryWarningNotification,
            object: app,
            queue: .main,
            using: { [weak self] _ in
                self?.didReceiveMemoryWarning.emit()
            }))
        
    }
    
}
