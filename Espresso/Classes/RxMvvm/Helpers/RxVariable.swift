//
//  ObservableVariable.swift
//  Espresso
//
//  Created by Mitch Treece on 11/4/18.
//

import Foundation
import RxSwift
import RxCocoa

public typealias RxVariable<Element> = BehaviorRelay<Element>

public extension RxVariable {
    
    /**
     Createsa read-only version of this variable.
     - Returns: A `RxReadOnlyVariable<Element>` instance of this read-write variable.
     */
    func asReadOnly() -> RxReadOnlyVariable<Element> {
        return RxReadOnlyVariable<Element>(self)
    }
    
}

/**
 A read-only Rx variable.
 */
public final class RxReadOnlyVariable<Element>: ObservableType {
    
    public typealias E = Element
    
    private let variable: RxVariable<Element>
    
    /// The variable's value.
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
