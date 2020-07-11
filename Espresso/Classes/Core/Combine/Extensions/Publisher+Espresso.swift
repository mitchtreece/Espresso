//
//  Publisher+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 6/24/20.
//

import Combine

@available(iOS 13, *)
public extension Publisher /* Sinks */ {
    
    /// Attaches a subscriber with closure-based behavior.
    ///
    /// This method creates the subscriber and immediately requests an unlimited number of values, prior to returning the subscriber.
    /// The return value should be held, otherwise the stream will be canceled.
    ///
    /// - parameter receiveValue: The closure to execute on receipt of a value.
    /// - parameter receiveComplete: The closure to execute on completion.
    /// - Returns: A cancellable instance, which you use when you end assignment of the received value. Deallocation of the result will tear down the subscription stream.
    func sink(receiveValue: @escaping (Output)->(),
              receiveCompletion: @escaping (Subscribers.Completion<Failure>)->()) -> AnyCancellable {
        
        return sink(
            receiveCompletion: receiveCompletion,
            receiveValue: receiveValue
        )
        
    }
    
    /// Attaches a subscriber with a result-based behavior.
    ///
    /// This method creates the subscriber and holds the latest value until a completion event is received.
    /// - parameter body: The closure to execute on completion.
    /// - returns: A cancellable instance; used when you end assignment of the received value. Deallocation
    /// of the result will tear down the subscription stream.
    func resultSink(_ body: @escaping (Result<Output, Failure>)->()) -> AnyCancellable {
        
        var _value: Output!
        
        return sink(
            receiveValue: { _value = $0 },
            receiveCompletion: { completion in
            
                switch completion {
                case .finished: body(.success(_value))
                case .failure(let err): body(.failure(err))
                }
            
            })
        
    }
    
    /// Attaches a subscriber with a value-based behavior.
    ///
    /// This method creates the subscriber & requests only values. Errors are ignored.
    /// - parameter body: The value subscription closure.
    /// - returns: A cancellable instance; used when you end assignment of the received value. Deallocation
    /// of the result will tear down the subscription stream.
    func valueSink(_ body: @escaping (Output)->()) -> AnyCancellable {
        
        return sink(
            receiveValue: { body($0) },
            receiveCompletion: { _ in }
        )
        
    }
        
}
