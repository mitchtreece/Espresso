//
//  ThreadSafe.swift
//  Espresso
//
//  Created by Mitch Treece on 11/18/24.
//

import Foundation

/// Class that wraps a value, and ensures thread-safe reads & writes.
public final class ThreadSafe<T>: @unchecked Sendable {
    
    private let queue = DispatchQueue(label: "espresso.queue.thread-safe")
    private var _value: T
    
    /// The thread-safe value.
    public var value: T {
        get {
            return self.queue.sync {
                self._value
            }
        }
        set {
            self.queue.sync {
                self._value = newValue
            }
        }
    }
    
    /// Initializes a thread-safe value.
    ///
    /// - parameter value: The wrapper's initial value.
    public init(_ value: T) {
        self._value = value
    }
    
    /// Initializes a thread-safe value.
    public convenience init() where T: OptionalType {
        
        let value: T.Wrapped? = nil
        self.init(value as! T)
        
    }
    
}
