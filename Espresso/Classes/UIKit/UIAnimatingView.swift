//
//  UIAnimatingView.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

public class UIAnimatingView: UIView {
    
    fileprivate var observer: NotificationObserver!
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        registerForNotifications()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        registerForNotifications()
    }
    
    private func registerForNotifications() {
        
        observer = NotificationObserver(name: .UIApplicationDidBecomeActive, object: nil) { [weak self] (notification) in
            self?.startAnimations()
        }
        
    }
    
    public override func didMoveToWindow() {
        
        super.didMoveToWindow()
        
        if window != nil {
            startAnimations()
        }
        
    }
    
    public func startAnimations() {
        // Override me
    }
    
}
