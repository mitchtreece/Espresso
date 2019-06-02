//
//  ObservableType+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import Foundation
import RxSwift
import RxCocoa

/**
 An observable value box over a type.
 */
public struct ObservableValueBox<T> {
    
    /// The box's underlying value.
    public var value: T
    
}

public extension ObservableType {
    
    /**
     Subscribes observer to receive events for this sequence by providing the old and new values.
     - Parameter onValueChange: The value changed handler.
     - Parameter oldValue: The stream's old (previous) value.
     - Parameter newValue: The streams new value.
     - Parameter onError: The error handler; _defaults to nil_.
     - Parameter error: The error.
     - Parameter onCompleted: The completion handler; _defaults to nil_.
     - Parameter onDisposed: The dispose handler; _defaults to nil_.
     - Returns: A disposable.
     */
    public func subscribe(onValueChange: @escaping (_ oldValue: ObservableValueBox<Self.E>, _ newValue: ObservableValueBox<Self.E>)->(),
                          onError: ((_ error: Error)->())? = nil,
                          onCompleted: (()->())? = nil,
                          onDisposed: (()->())? = nil) -> Disposable {
        
        let array = [Self.E]()
        
        return scan(array) { (prev, next) -> [Self.E] in
            
            var values = prev
            values.append(next)
            return Array(values.suffix(2))
            
        }
        .map { $0.map { ObservableValueBox<Self.E>(value: $0) } }
        .map { ($0.first!, $0.last!) }
        .subscribe(onNext: onValueChange, onError: onError, onCompleted: onCompleted, onDisposed: onDisposed)
        
    }
    
}
