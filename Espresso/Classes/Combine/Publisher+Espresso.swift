//
//  Publisher+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine

@available(iOS 13, *)
public extension Publisher where Failure == Never {
    
    /// Latest value of the publisher's output sequence.
    var value: Self.Output {
        
        var value: Self.Output!
        var bag = CancellableBag()
        
        sink { value = $0 }
            .store(in: &bag)
        
        return value
        
    }
    
    /// Republishes elements received from a publisher,
    /// by weakly assigning them to a property marked as a publisher.
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
