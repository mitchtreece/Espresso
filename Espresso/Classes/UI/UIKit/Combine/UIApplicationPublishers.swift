//
//  UIApplicationPublishers.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import UIKit

/// Application publisher collection class.
public class UIApplicationPublishers {
    
    /// A publisher that sends when the application finishes becoming active.
    public var didBecomeActive: GuaranteePublisher<Void> {
        return self._didBecomeActive.asPublisher()
    }
    
    /// A publisher that sends when the application is about to become inactive.
    public var willResignActive: GuaranteePublisher<Void> {
        return self._willResignActive.asPublisher()
    }
    
    /// A publisher that sends when the application finishes entering the background.
    public var didEnterBackground: GuaranteePublisher<Void> {
        return self._didEnterBackground.asPublisher()
    }
    
    /// A publisher that sends when the application is about to enter the foreground.
    public var willEnterForeground: GuaranteePublisher<Void> {
        return self._willEnterForeground.asPublisher()
    }
    
    /// A publisher that sends when the application is about to terminate.
    public var willTerminate: GuaranteePublisher<Void> {
        return self._willTerminate.asPublisher()
    }
    
    /// A publisher that sends when the application's protected data availability is about to change.
    public var protectedDataAvailabilityWillChange: GuaranteePublisher<Bool> {
        return self._protectedDataAvailabilityWillChange.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the application receives a significant time change.
    public var significantTimeChange: GuaranteePublisher<Void> {
        return self._significantTimeChange.asPublisher()
    }
    
    /// A publisher that sends when the application receives a background-refresh status change.
    public var backgroundRefreshStatusChange: GuaranteePublisher<Void> {
        return self._backgroundRefreshStatusChange.asPublisher()
    }
    
    /// A publisher that sends when the application is screenshot by the user.
    public var userDidTakeScreenshot: GuaranteePublisher<Void> {
        return self._userDidTakeScreenshot.asPublisher()
    }
    
    /// A publisher that sends when the application receives a memory warning.
    public var didReceiveMemoryWarning: GuaranteePublisher<Void> {
        return self._didReceiveMemoryWarning.asPublisher()
    }
    
    private var _didBecomeActive = TriggerPublisher()
    private var _willResignActive = TriggerPublisher()
    private var _didEnterBackground = TriggerPublisher()
    private var _willEnterForeground = TriggerPublisher()
    private var _willTerminate = TriggerPublisher()
    private var _protectedDataAvailabilityWillChange = GuaranteePassthroughSubject<Bool>()
    private var _significantTimeChange = TriggerPublisher()
    private var _backgroundRefreshStatusChange = TriggerPublisher()
    private var _userDidTakeScreenshot = TriggerPublisher()
    private var _didReceiveMemoryWarning = TriggerPublisher()
    
    private var bag = CancellableBag()
    
    deinit {
        self.bag.removeAll()
    }
    
    internal init() {
        
        NotificationCenter.default
            .publisher(for: UIApplication.didBecomeActiveNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self._didBecomeActive.fire() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.willResignActiveNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self._willResignActive.fire() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.didEnterBackgroundNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self._didEnterBackground.fire() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.willEnterForegroundNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self._willEnterForeground.fire() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.willTerminateNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self._willTerminate.fire() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.protectedDataDidBecomeAvailableNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self._protectedDataAvailabilityWillChange.send(true) }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.protectedDataWillBecomeUnavailableNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self._protectedDataAvailabilityWillChange.send(false) }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.significantTimeChangeNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self._significantTimeChange.fire() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.backgroundRefreshStatusDidChangeNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self._backgroundRefreshStatusChange.fire() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.userDidTakeScreenshotNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self._userDidTakeScreenshot.fire() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.didReceiveMemoryWarningNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self._didReceiveMemoryWarning.fire() }
            .store(in: &self.bag)
        
    }
    
}
