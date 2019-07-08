//
//  ObservableVariable.swift
//  Espresso
//
//  Created by Mitch Treece on 11/4/18.
//

import RxSwift
import RxCocoa

public typealias RxVariable<Element> = BehaviorRelay<Element>

public extension RxVariable /* Read Only */ {
    
    /**
     Createsa read-only version of this variable.
     - Returns: A `RxReadOnlyVariable<Element>` instance of this read-write variable.
     */
    func asReadOnly() -> RxReadOnlyVariable<Element> {
        return RxReadOnlyVariable<Element>(self)
    }
    
}
