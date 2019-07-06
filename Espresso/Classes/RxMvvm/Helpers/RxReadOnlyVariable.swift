//
//  RxReadOnlyVariable.swift
//  Director
//
//  Created by Mitch Treece on 7/6/19.
//

import RxSwift
import RxCocoa

/**
 A read-only Rx variable.
 */
public final class RxReadOnlyVariable<Element>: ObservableType {
    
    public typealias E = Element
    
    private let variable: RxVariable<Element>
    
    /// The variable's current value.
    public var value: Element {
        return self.variable.value
    }
    
    /**
     Initializes a `RxReadOnlyVariable` with a read-write variable.
     - Parameter variable: The underlying read-write variable.
     */
    public init(_ variable: RxVariable<Element>) {
        self.variable = variable
    }
    
    /**
     Initializes a `RxReadOnlyVariable` with a value.
     - Parameter value: The underlying variable's value.
     */
    public convenience init(value: Element) {
        self.init(RxVariable<Element>(value: value))
    }
    
    public func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.Element == E {
        return self.variable.subscribe(observer)
    }
    
    public func asObservable() -> Observable<Element> {
        return self.variable.asObservable()
    }
    
}
