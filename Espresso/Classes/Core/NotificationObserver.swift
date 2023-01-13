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
    /// - parameter queue: The operation queue where the `block` runs.
    /// When nil, the block runs synchronously on the posting thread.; _defaults to main_.
    /// - Parameter block: The observation handler block.
    public init(name: Notification.Name,
                object: Any?,
                queue: OperationQueue? = .main,
                block: @escaping (Notification)->()) {
        
        self.name = name
        
        self.observer = NotificationCenter.default.addObserver(
            forName: name,
            object: object,
            queue: queue,
            using: block
        )
                
    }
    
    /// Initializes a new `NotificationObserver` with specified parameters.
    /// - Parameter name: The observed notification's name.
    /// - Parameter object: The object whose notifications the observer wants to receive.
    /// - parameter queue: The operation queue where the `block` runs.
    /// When nil, the block runs synchronously on the posting thread.; _defaults to main_.
    /// - Parameter block: The observation handler block.
    public convenience init(name: String,
                            object: Any?,
                            queue: OperationQueue? = .main,
                            block: @escaping (Notification)->()) {
        
        self.init(
            name: Notification.Name(name),
            object: object,
            queue: queue,
            block: block
        )
        
    }
    
    deinit {
        
        guard let observer = self.observer else { return }
        
        NotificationCenter
            .default
            .removeObserver(observer)
        
    }
    
}
