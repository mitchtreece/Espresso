//
//  ObservableType+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import RxSwift
import RxCocoa

public extension ObservableType /* Value */ {
    
    /// Latest value of the observable sequence.
    var value: Self.Element {
        
        var value: Self.Element!
        let disposeBag = DisposeBag()
        
        subscribe(onNext: { _value in
            value = _value
        })
        .disposed(by: disposeBag)
        
        return value
        
    }
    
}

public extension ObservableType where Element: OptionalType /* Optional */ {
    
    /// Filters optional elements out of an observable sequence.
    func `guard`() -> Observable<Element.Wrapped> {
        
        return self.flatMap { element -> Observable<Element.Wrapped> in
            guard let value = element.wrappedValue else { return Observable<Element.Wrapped>.empty() }
            return Observable<Element.Wrapped>.just(value)
        }
        
    }
    
}

public extension ObservableType where Element == Bool /* Bool */ {
    
    /// Filters `false` elements out of an observable ssequence.
    func isTrue() -> Observable<Element> {
        return self.filter { $0 }
    }
    
    /// Filters `true` elements out of an observable ssequence.
    func isFalse() -> Observable<Element> {
        return self.filter { !$0 }
    }
    
}
