//
//  Publisher+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine

@available(iOS 13, *)
public extension Publisher where Failure == Never {
    
    var value: Self.Output {
        
        var value: Self.Output!
        var bag = CancellableBag()
        
        sink { value = $0 }
            .store(in: &bag)
        
        return value
        
    }
    
    func weakAssign<T: AnyObject>(to keyPath: ReferenceWritableKeyPath<T, Output>,
                                  on object: T) -> AnyCancellable {
        
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }

    }
    
}

@available(iOS 13, *)
public extension Publisher where Output == Bool {

    /// Filters `false` outputs out of a publisher sequence.
    func isTrue() -> AnyPublisher<Output, Failure> {
        
        return filter { $0 }
            .eraseToAnyPublisher()
        
    }

    /// Filters `true` outputs out of a publisher ssequence.
    func isFalse() -> AnyPublisher<Output, Failure> {
        
        return filter { !$0 }
            .eraseToAnyPublisher()
        
    }

}
