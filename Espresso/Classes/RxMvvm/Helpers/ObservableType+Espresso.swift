//
//  ObservableType+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import RxSwift
import RxCocoa

/**
 An observable value box over a type.
 */
public struct ObservableValueBox<T> {
    
    /// The box's underlying value.
    public var value: T
    
}

public extension ObservableType /* Value */ {
    
    /// Current value of the observable type.
    var value: Self.Element {
        
        var value: Self.Element!
        let disposeBag = DisposeBag()
        
        self.subscribe(onNext: { _value in
            value = _value
        }).disposed(by: disposeBag)
        
        return value
        
    }
    
}

public extension ObservableType /* Value Change */ {
    
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
    func subscribe(onValueChange: @escaping (_ oldValue: ObservableValueBox<Self.Element>, _ newValue: ObservableValueBox<Self.Element>)->(),
                   onError: ((_ error: Error)->())? = nil,
                   onCompleted: (()->())? = nil,
                   onDisposed: (()->())? = nil) -> Disposable {
        
        let array = [Self.Element]()
        
        return scan(array) { (prev, next) -> [Self.Element] in
            
            var values = prev
            values.append(next)
            return Array(values.suffix(2))
            
        }
        .map { $0.map { ObservableValueBox<Self.Element>(value: $0) } }
        .map { ($0.first!, $0.last!) }
        .subscribe(onNext: onValueChange, onError: onError, onCompleted: onCompleted, onDisposed: onDisposed)
        
    }
    
}
