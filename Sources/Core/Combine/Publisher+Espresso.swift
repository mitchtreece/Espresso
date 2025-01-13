//
//  Publisher+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine
import Dispatch

public extension Publisher /* Any */ {
    
    /// Wraps this publisher with a type eraser.
    /// - returns: An `AnyPublisher` wrapping this publisher.
    func asAny() -> AnyPublisher<Self.Output, Self.Failure> {
        return eraseToAnyPublisher()
    }
    
}

public extension Publisher where Failure == Never /* Value */ {
    
//    /// Latest value of the publisher's output sequence.
//    ///
//    /// - Warning: This assumes the publisher has values in its stream.
//    ///   If it doesn't, calling this will throw an exception. For example,
//    ///   when using a `PassthroughSubject` and erasing to an `AnyPublisher`,
//    ///   calling this will throw a `nil` excpetion as `PassthroughSubject`
//    ///   does not hold onto any stream values.
//    ///
//    /// - Tip: Consider using ``value(or:)`` or ``valueThrowing`` when
//    ///   unsure of semantics around an underlying subject.
//    ///
//    /// - Tip: When implementing a subject and exposing it through a
//    ///   type-erased `AnyPublisher`, it's a good idea to follow a consistent
//    ///   naming convention. Consider using an `on` prefix _or_ `Passthrough`
//    ///   suffix for publishers backed by a `PassthroughSubject` to convey
//    ///   that a given publisher simply emits values without holding onto them.
//    ///
//    /// ```swift
//    /// private let valueSubject = CurrentValueSubject<Int, Never>(0)
//    /// var value: AnyPublisher<Int, Never> { ... }
//    ///
//    /// private let passthroughSubject = PassthroughSubject<Int, Never>()
//    /// var onValue: AnyPublisher<Int, Never> { ... }
//    /// var valuePassthrough: AnyPublisher<Int, Never> { ... }
//    /// ```
//    var value: Self.Output {
//        
//        var value: Self.Output!
//        var bag = CancellableBag()
//        
//        sink { value = $0 }
//            .store(in: &bag)
//        
//        return value
//        
//    }
    
    /// Latest value of the publisher's output sequence.
    /// This throws an error if the publisher has no values in its stream.
    var value: Self.Output {
        get throws {
            
            var value: Self.Output?
            var bag = CancellableBag()
            
            sink { value = $0 }
                .store(in: &bag)
            
            if let value {
                return value
            }
            else {
                throw PublisherError.emptyStream
            }
            
        }
    }
        
    /// Latest value of the publisher's output sequence _or_ a default
    /// value if accessing `value` would throw an error, or result in `nil`.
    func value(or default: Self.Output) -> Self.Output {
        return (try? self.value) ?? `default`
    }
    
}

public extension Publisher /* Scheduling */ {
    
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

public extension Publisher where Output: OptionalType /* Optional */ {
    
    /// Filters `nil` outputs out of a publisher sequence.
    func `guard`() -> AnyPublisher<Output.Wrapped, Failure> {
        
        return filter { $0.wrappedValue != nil }
            .map { $0.wrappedValue! }
            .eraseToAnyPublisher()
                
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

public extension Publisher where Output == Bool /* Bool */ {
    
    /// Filters `false` outputs out of a publisher sequence.
    func isTrue() -> AnyPublisher<Output, Failure> {
        
        return filter { $0 }
            .eraseToAnyPublisher()
        
    }

    /// Filters `true` outputs out of a publisher sequence.
    func isFalse() -> AnyPublisher<Output, Failure> {
        
        return filter { !$0 }
            .eraseToAnyPublisher()
        
    }

}
