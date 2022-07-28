//
//  KeyboardManager.swift
//  Espresso
//
//  Created by Mitch Treece on 7/28/22.
//

import UIKit

public typealias KeyboardAnimationInfo = (
    
    frame: CGRect,
    duration: TimeInterval,
    options: UIView.AnimationOptions
    
)

public protocol KeyboardObserver {
    
    var keyboardObserverId: String { get }
    
    func didReceiveKeyboardEvent(_ event: KeyboardManager.Event,
                                 animationInfo: KeyboardAnimationInfo)
    
}

public class KeyboardManager {
    
    public enum Event {
        
        case willShow
        case willChangeFrame
        case willHide
        case didHide
        
    }
    
    public static let shared = KeyboardManager()
    
    private var willShowObserver: NotificationObserver!
    private var willChangeFrameObserver: NotificationObserver!
    private var willHideObserver: NotificationObserver!
    private var didHideObserver: NotificationObserver!
    
    public private(set) var currentKeyboardFrame: CGRect?
    public private(set) var isKeyboardVisible = false
    
    private var observers = [String: KeyboardObserver]()
    
    private init() {
        
        self.willShowObserver = NotificationObserver(
            
            name: UIResponder.keyboardWillShowNotification,
            object: nil
            
        ) { [weak self] notification in
            
            guard let self = self else { return }
            guard !self.isKeyboardVisible else { return }
            
            self.notifyObservers(
                event: .willShow,
                info: self.animationInfo(notification)
            )
            
            self.isKeyboardVisible = true
            
        }
        
        self.willChangeFrameObserver = NotificationObserver(
            
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
            
        ) { [weak self] notification in
            
            guard let self = self else { return }
            
            let info = self.animationInfo(notification)
            
            self.notifyObservers(
                event: .willChangeFrame,
                info: info
            )
            
            self.currentKeyboardFrame = info.frame
            
        }

        self.willHideObserver = NotificationObserver(
            
            name: UIResponder.keyboardWillHideNotification,
            object: nil
            
        ) { [weak self] notification in
            
            guard let self = self else { return }
            guard self.isKeyboardVisible else { return }
            
            self.notifyObservers(
                event: .willHide,
                info: self.animationInfo(notification)
            )
            
            self.isKeyboardVisible = false
            
        }
        
        self.didHideObserver = NotificationObserver(
            
            name: UIResponder.keyboardDidHideNotification,
            object: nil
            
        ) { [weak self] _ in
            
            self?.currentKeyboardFrame = nil
            
        }
        
    }
    
    public static func animate(using info: KeyboardAnimationInfo,
                               animations: @escaping ()->(),
                               completion: (()->())? = nil) {
        
        UIView.animate(
            withDuration: info.duration,
            delay: 0,
            options: info.options,
            animations: animations,
            completion: { _ in completion?() }
        )
        
    }
    
    public func add(observer: KeyboardObserver) {
        
        let id = observer.keyboardObserverId
        
        if !self.observers.keys.contains(id) {
            self.observers[id] = observer
        }
        
    }
    
    public func remove(observer: KeyboardObserver) {
        
        let id = observer.keyboardObserverId
        
        if self.observers.keys.contains(id) {
            self.observers.removeValue(forKey: id)
        }
        
    }
    
    public func removeAllObservers() {
        self.observers.removeAll()
    }
    
    // MARK: Private
    
    private func notifyObservers(event: Event,
                                 info: KeyboardAnimationInfo) {
        
        self.observers.forEach { pair in
            
            pair.value.didReceiveKeyboardEvent(
                event,
                animationInfo: info
            )
            
        }
        
    }
    
    private func animationInfo(_ notification: Notification) -> KeyboardAnimationInfo {
        
        let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? CGRect.zero
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0
        let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt ?? 0
        let options = UIView.AnimationOptions(rawValue: curve)
        
        return KeyboardAnimationInfo(
            frame: frame,
            duration: duration,
            options: options
        )
        
    }
    
}
