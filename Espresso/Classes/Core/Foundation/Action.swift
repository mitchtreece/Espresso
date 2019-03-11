//
//  Action.swift
//  Espresso
//
//  Created by Mitch Treece on 3/10/19.
//

import Foundation

public protocol Action {
    
    associatedtype T
    func run(with data: T?)
    
}

public class DataAction<T>: Action {
    
    private let block: (T?)->()
    
    public init(_ block: @escaping (T?)->()) {
        self.block = block
    }
    
    public func run(with data: T?) {
        self.block(data)
    }
    
}

public class VoidAction: Action {
    
    public typealias T = Void
    
    private let block: ()->()
    
    public init(_ block: @escaping ()->()) {
        self.block = block
    }
    
    public func run(with data: T? = nil) {
        self.block()
    }
    
}
