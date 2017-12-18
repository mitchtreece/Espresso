//
//  NotificationObserver.swift
//  Espresso
//
//  Created by Mitch Treece on 12/16/17.
//

import Foundation

/**
 `NotificationObserver` is a simple block-based wrapper over `NotificationCenter` observation.
 */
public class NotificationObserver {
    
    private let observer: Any?
    private let name: Notification.Name
    
    public init(name: Notification.Name, object: Any?, block: @escaping (Notification)->()) {
        
        self.observer = NotificationCenter.default.addObserver(forName: name, object: object, queue: OperationQueue.main, using: block)
        self.name = name
        
    }
    
    public convenience init(name: String, object: Any?, block: @escaping (Notification)->()) {
        
        let _name = Notification.Name(name)
        self.init(name: _name, object: object, block: block)
        
    }
    
    deinit {
        
        guard let observer = observer else { return }
        NotificationCenter.default.removeObserver(observer)
        
    }
    
}
