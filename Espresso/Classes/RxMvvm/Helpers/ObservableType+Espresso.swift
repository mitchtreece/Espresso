//
//  ObservableType+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import Foundation
import RxSwift
import RxCocoa

public struct ObservableValueBox<T> {
    var value: T
}

public extension ObservableType {
    
    public func subscribe(onValueChange: @escaping (ObservableValueBox<Self.E>, ObservableValueBox<Self.E>)->(),
                          onError: ((Error)->())? = nil,
                          onCompleted: (()->())? = nil,
                          onDisposed: (()->())? = nil) -> Disposable {
        
        let array = [Self.E]()
        
        return scan(array) { (prev, next) -> [Self.E] in
            
            var values = prev
            values.append(next)
            return Array(values.suffix(2))
            
        }
        .map({ $0.map({ ObservableValueBox<Self.E>(value: $0) }) })
        .map({ ($0.first!, $0.last!) })
        .subscribe(onNext: onValueChange, onError: onError, onCompleted: onCompleted, onDisposed: onDisposed)
        
    }
    
}
