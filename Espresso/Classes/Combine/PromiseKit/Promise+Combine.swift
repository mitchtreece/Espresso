//
//  Promise+Combine.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import Combine
import PromiseKit

public extension Promise {
    
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
