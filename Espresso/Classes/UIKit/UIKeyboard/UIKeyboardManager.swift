//
//  UIKeyboardManager.swift
//  Espresso
//
//  Created by Mitch Treece on 12/17/17.
//

import UIKit

public typealias UIKeyboardAnimationContext = (
    endFrame: CGRect,
    duration: TimeInterval,
    options: UIViewAnimationOptions,
    isDismissal: Bool
)

internal class UIKeyboardManager {
    
    static let shared = UIKeyboardManager()
    
    private var willShowObserver: NotificationObserver!
    private var willHideObserver: NotificationObserver!
    private var didHideObserver: NotificationObserver!
    private var willChangeFrameObserver: NotificationObserver!
    
    private(set) var currentKeyboardFrame: CGRect?
    private(set) var isKeyboardVisible = false
    
    var keyObserver: UIKeyboardObserver?
    private var observers = [String: UIKeyboardObserver]()
    
    private init() {
        
        willShowObserver = NotificationObserver(name: .UIKeyboardWillShow, object: nil) { [weak self] (notification) in
            
            guard let _self = self else { return }
            
            let context = _self.context(fromKeyboardNotification: notification, isDismissal: false)
            _self.notifyObservers(with: context)
            _self.isKeyboardVisible = true
            
        }
        
        willHideObserver = NotificationObserver(name: .UIKeyboardWillHide, object: nil) { [weak self] (notification) in
            
            guard let _self = self else { return }
            
            let context = _self.context(fromKeyboardNotification: notification, isDismissal: true)
            _self.notifyObservers(with: context)
            _self.isKeyboardVisible = false
            
        }
        
        didHideObserver = NotificationObserver(name: .UIKeyboardDidHide, object: nil) { [weak self] (notification) in
            self?.currentKeyboardFrame = nil
        }
        
        willChangeFrameObserver = NotificationObserver(name: .UIKeyboardWillChangeFrame, object: nil) { [weak self] (notification) in
            
            if let info = notification.userInfo, let endFrame = info[UIKeyboardFrameEndUserInfoKey] as? CGRect {
                self?.currentKeyboardFrame = endFrame
            }
            
        }
        
    }
    
    func start() {
        print("⌨️ KeyboardManager started")
    }
    
    func add(observer: UIKeyboardObserver) {
        
        let id = observer.keyboardObserverId
        if !observers.keys.contains(id) {
            observers[id] = observer
        }
        
    }
    
    func remove(observer: UIKeyboardObserver) {
        
        let id = observer.keyboardObserverId
        if observers.keys.contains(id) {
            observers.removeValue(forKey: id)
        }
        
    }
    
    func removeAllObservers() {
        observers.removeAll()
    }
    
    private func context(fromKeyboardNotification notification: Notification, isDismissal: Bool) -> UIKeyboardAnimationContext {
        
        let frame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect ?? CGRect.zero
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0
        let curve = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? UInt ?? 0
        let options = UIViewAnimationOptions(rawValue: curve)
        return UIKeyboardAnimationContext(endFrame: frame, duration: duration, options: options, isDismissal: isDismissal)
        
    }
    
    private func notifyObservers(with context: UIKeyboardAnimationContext) {
        
        guard let observer = keyObserver, observers.keys.contains(observer.keyboardObserverId) else { return }
        context.isDismissal ? observer.keyboardWillHide(with: context) : observer.keyboardWillShow(with: context)
        
    }
    
}
