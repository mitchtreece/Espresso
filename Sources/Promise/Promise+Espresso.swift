//
//  Promise+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 7/25/22.
//

import Combine
import Dispatch
import PromiseKit

public extension Resolver where T == Void /* Void */ {
    
    /// Fulfills the promise without a value.
    func fulfill() {
        fulfill(())
    }
    
}

public extension Promise /* Optional */ {

    /// Maps the promise to new one over an optional-version of it's value type.
    /// - returns: A promise over an optional value.
    func asOptional() -> Promise<T?> {
        map { $0 as T? }
    }

}

public extension Promise /* Combine */ {
    
    /// Creates a publisher over this promise.
    /// - returns: A new publisher.
    func asPublisher() -> FailablePublisher<T> {
        
        return FailableFuture<T>{ promise in
            
            self.done { value in
                promise(.success(value))
            }
            .catch { error in
                promise(.failure(error))
            }
            
        }
        .eraseToAnyPublisher()
        
    }
    
}

public extension Promise /* Async */ {
    
    /// Creates an async task over this promise.
    /// - returns: An async value.
    func asAsync() async throws -> T {
        return try await async()
    }
    
}

// MARK: Retry

/// Retries a promise using a given behavior.
/// - parameter behavior: The retry behavior; _default to immediate(count: 1)_.
/// - parameter body: A closure returning a promise.
/// - returns: A promise.
public func retry<T>(_ behavior: Promise<T>.RetryBehavior = .immediate(count: 1),
                     _ body: @escaping ()->Promise<T>) -> Promise<T> {

    var attempts: UInt = 0

    func attempt() -> Promise<T> {

        attempts += 1

        return body().recover { error -> Promise<T> in

            let (maxCount, delay) = behavior.calculate(attempts)
            guard attempts < maxCount else { throw error }
            
            return after(delay)
                .then(on: nil, attempt)

        }

    }

    return attempt()

}

public extension Promise {
    
    /// Representation of the various ways a promise can behave while retrying.
    enum RetryBehavior {

        /// A behavior that retries immediately.
        case immediate(count: UInt)

        /// A behavior that retries after a delay.
        case delayed(count: UInt, delay: TimeInterval)

        /// A behavior that retries after an exponential delay.
        case exponentialDelayed(count: UInt, delay: TimeInterval, multiplier: Double)

        /// A behavior that retries using a custom delay calculator.
        case custom(count: UInt, calculator: (UInt) -> (DispatchTimeInterval))

        /// Calculates the retry behavior's values for a given iteration.
        /// - parameter iteration: The retry iteration.
        func calculate(_ iteration: UInt) -> (count: UInt, delay: DispatchTimeInterval) {

            switch self {
            case .immediate(let count): return (count: count, delay: .never)
            case .delayed(let count, let delay): return (count: count, delay: .milliseconds(Int(delay * 1000)))
            case .exponentialDelayed(let count, let delay, let multiplier):

                let expDelay = (iteration == 1) ? delay : (delay * pow(1 + multiplier, Double(iteration - 1)))
                return (count: count, delay: .milliseconds(Int(expDelay * 1000)))

            case .custom(let count, let calculator): return (count: count, delay: calculator(iteration))
            }

        }

    }
    
    /// Retries the promise using a given behavior.
    /// - parameter behavior: The retry behavior; _default to immediate(count: 1)_.
    /// - returns: A promise.
    func retry(_ behavior: RetryBehavior = .immediate(count: 1)) -> Promise<T> {

        var attempts: UInt = 0

        func attempt() -> Promise<T> {

            attempts += 1

            return recover(policy: CatchPolicy.allErrorsExceptCancellation) { error -> Promise<T> in

                let (maxCount, delay) = behavior.calculate(attempts)
                guard attempts < maxCount else { throw error }
                
                return after(delay)
                    .then(on: nil, attempt)

            }

        }

        return attempt()

    }
    
}
