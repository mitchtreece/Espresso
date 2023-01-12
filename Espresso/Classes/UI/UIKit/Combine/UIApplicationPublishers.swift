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
    public var didBecomeActivePublisher: GuaranteePublisher<Void> {
        return self.didBecomeActive.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the application is about to become inactive.
    public var willResignActivePublisher: GuaranteePublisher<Void> {
        return self.willResignActive.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the application finishes entering the background.
    public var didEnterBackgroundPublisher: GuaranteePublisher<Void> {
        return self.didEnterBackground.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the application is about to enter the foreground.
    public var willEnterForegroundPublisher: GuaranteePublisher<Void> {
        return self.willEnterForeground.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the application is about to terminate.
    public var willTerminatePublisher: GuaranteePublisher<Void> {
        return self.willTerminate.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the application's protected data availability is about to change.
    public var protectedDataAvailabilityWillChangePublisher: GuaranteePublisher<Bool> {
        return self.protectedDataAvailabilityWillChange.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the application receives a significant time change.
    public var significantTimeChangePublisher: GuaranteePublisher<Void> {
        return self.significantTimeChange.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the application receives a background-refresh status change.
    public var backgroundRefreshStatusChangePublisher: GuaranteePublisher<Void> {
        return self.backgroundRefreshStatusChange.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the application is screenshot by the user.
    public var userDidTakeScreenshotPublisher: GuaranteePublisher<Void> {
        return self.userDidTakeScreenshot.eraseToAnyPublisher()
    }
    
    /// A publisher that sends when the application receives a memory warning.
    public var didReceiveMemoryWarningPublisher: GuaranteePublisher<Void> {
        return self.didReceiveMemoryWarning.eraseToAnyPublisher()
    }
    
    private var didBecomeActive = TriggerPublisher()
    private var willResignActive = TriggerPublisher()
    private var didEnterBackground = TriggerPublisher()
    private var willEnterForeground = TriggerPublisher()
    private var willTerminate = TriggerPublisher()
    private var protectedDataAvailabilityWillChange = GuaranteePassthroughSubject<Bool>()
    private var significantTimeChange = TriggerPublisher()
    private var backgroundRefreshStatusChange = TriggerPublisher()
    private var userDidTakeScreenshot = TriggerPublisher()
    private var didReceiveMemoryWarning = TriggerPublisher()
    
    private var bag = CancellableBag()
    
    deinit {
        self.bag.removeAll()
    }
    
    internal init() {
        
        NotificationCenter.default
            .publisher(for: UIApplication.didBecomeActiveNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self.didBecomeActive.send() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.willResignActiveNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self.willResignActive.send() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.didEnterBackgroundNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self.didEnterBackground.send() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.willEnterForegroundNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self.willEnterForeground.send() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.willTerminateNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self.willTerminate.send() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.protectedDataDidBecomeAvailableNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self.protectedDataAvailabilityWillChange.send(true) }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.protectedDataWillBecomeUnavailableNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self.protectedDataAvailabilityWillChange.send(false) }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.significantTimeChangeNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self.significantTimeChange.send() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.backgroundRefreshStatusDidChangeNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self.backgroundRefreshStatusChange.send() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.userDidTakeScreenshotNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self.userDidTakeScreenshot.send() }
            .store(in: &self.bag)
        
        NotificationCenter.default
            .publisher(for: UIApplication.didReceiveMemoryWarningNotification)
            .receiveOnMain()
            .sink { [unowned self] _ in self.didReceiveMemoryWarning.send() }
            .store(in: &self.bag)
        
    }
    
}
