//
//  Publisher+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine

public extension Publisher /* Main Queue */ {
    
    /// Specifies `DispatchQueue.main` as the publisher's
    /// subscribe, cancel, & request operation scheduler.
    func subscribeOnMain(options: DispatchQueue.SchedulerOptions? = nil) -> Publishers.SubscribeOn<Self, DispatchQueue> {
        
        return subscribe(
            on: .main,
            options: options
        )
        
    }
    
    /// Specifies `DispatchQueue.main` as the receiving
    /// scheduler for published elements.
    func receiveOnMain(options: DispatchQueue.SchedulerOptions? = nil) -> Publishers.ReceiveOn<Self, DispatchQueue> {
                
        return receive(
            on: .main,
            options: options
        )
        
    }
    
}

//public extension Publisher {
//    
//    func inject(_ block: ()->()) -> Self {
//        
//    }
//    
//}

public extension Publisher where Failure == Never /* Value */ {
    
    /// Latest value of the publisher's output sequence.
    var value: Self.Output {
        
        var value: Self.Output!
        var bag = CancellableBag()
        
        sink { value = $0 }
            .store(in: &bag)
        
        return value
        
    }
    
}

public extension Publisher where Failure == Never /* Weak */ {
    
    /// Attaches a weak subscriber with closure-based
    /// behavior to a publisher that never fails.
    func weakSink<T: AnyObject>(capturing object: T,
                                receiveValue: @escaping (T?, Output)->Void) -> AnyCancellable {
        
        return sink { [weak object] value in
            receiveValue(object, value)
        }
        
    }
    
    /// Republishes elements received from a publisher,
    /// by weakly assigning them to a property marked as a publisher.
    func weakAssign<T: AnyObject>(to keyPath: ReferenceWritableKeyPath<T, Output>,
                                  on object: T) -> AnyCancellable {
        
        return weakSink(capturing: object) { wObject, value in
            wObject?[keyPath: keyPath] = value
        }
        
    }
    
}

public extension Publisher where Output == Bool /* Bool Operators */ {

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
