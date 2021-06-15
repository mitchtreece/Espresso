//
//  NotificationObserver.swift
//  Espresso
//
//  Created by Mitch Treece on 12/16/17.
//

import Foundation

/// Closure-based wrapper over `NotificationCenter` observation.
public class NotificationObserver {
    
    private let observer: Any?
    private let name: Notification.Name
    
    /// Initializes a new `NotificationObserver` with specified parameters.
    /// - Parameter name: The observed notification's name.
    /// - Parameter object: The object whose notifications the observer wants to receive.
    /// - Parameter block: The observation handler block.
    public init(name: Notification.Name, object: Any?, block: @escaping (Notification)->()) {
        
        self.observer = NotificationCenter.default.addObserver(forName: name, object: object, queue: OperationQueue.main, using: block)
        self.name = name
        
    }
    
    /// Initializes a new `NotificationObserver` with specified parameters.
    /// - Parameter name: The observed notification's name.
    /// - Parameter object: The object whose notifications the observer wants to receive.
    /// - Parameter block: The observation handler block.
    public convenience init(name: String, object: Any?, block: @escaping (Notification)->()) {
        
        let _name = Notification.Name(name)
        self.init(name: _name, object: object, block: block)
        
    }
    
    deinit {
        
        guard let observer = observer else { return }
        NotificationCenter.default.removeObserver(observer)
        
    }
    
}
