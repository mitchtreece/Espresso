//
//  RxVariableProxy.swift
//  Director
//
//  Created by Mitch Treece on 7/6/19.
//

import RxSwift
import RxCocoa

/*
 An Rx variable proxy class.
 */
public final class RxVariableProxy<Element> {
    
    public private(set) var variable: RxReadOnlyVariable<Element>
    private var _variable: RxVariable<Element>
    
    /// The underlying variable as an `Observable` sequence.
    public var observable: Observable<Element> {
        return self.variable.asObservable()
    }
    
    /// The underlying variable's current value.
    public var value: Element {
        return self.variable.value
    }
    
    public init(value: Element) {
        self._variable = RxVariable<Element>(value: value)
        self.variable = self._variable.asReadOnly()
    }
    
    /// Accepts `event` and emits it to subscribers.
    public func accept(_ event: Element) {
        self._variable.accept(event)
    }
    
}
