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
public class BroadcastObserver {
    
    private let observer: Any?
    private let name: String
    
    public init(name: String, object: Any?, block: @escaping (Notification) -> ()) {
        
        let notificationName = NSNotification.Name(rawValue: name)
        self.observer = NotificationCenter.default.addObserver(forName: notificationName, object: object, queue: OperationQueue.main, using: block)
        self.name = name
        
    }
    
    deinit {
        
        guard let observer = observer else { return }
        NotificationCenter.default.removeObserver(observer)
        
    }
    
}
