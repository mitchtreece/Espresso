//
//  Promise+Rx.swift
//  Espresso
//
//  Created by Mitch Treece on 7/28/22.
//

import RxSwift
import PromiseKit

public extension Promise {
    
    /// Creates an observable over this promise.
    /// - returns: A new observable.
    func asObservable() -> Observable<T> {
        
        return Single<T>.create { observer in
            
            self.done { value in
                observer(.success(value))
            }
            .catch { error in
                observer(.failure(error))
            }
            
            return Disposables.create()
            
        }
        .asObservable()
        
    }
    
}
