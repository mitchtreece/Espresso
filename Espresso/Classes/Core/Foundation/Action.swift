//
//  Action.swift
//  Espresso
//
//  Created by Mitch Treece on 3/10/19.
//

import Foundation

/**
 Protocol describing the base attributes of an action.
 */
public protocol Action {
    
    associatedtype T
    
    /**
     Runs the action with a given data object.
     - Parameter data: The data object.
     */
    func run(with data: T?)
    
}

/**
 An action that is executed with given data.
 */
public class DataAction<T>: Action {
    
    private let block: (T?)->()
    
    /**
     Initializes an action using a given execution block.
     - Parameter block: The action's execution block.
     */
    public init(_ block: @escaping (T?)->()) {
        self.block = block
    }
    
    public func run(with data: T?) {
        self.block(data)
    }
    
}

/**
 An action that is executed without any data.
 */
public class VoidAction: Action {
    
    public typealias T = Void
    
    private let block: ()->()
    
    /**
     Initializes an action using a given execution block.
     - Parameter block: The action's execution block.
     */
    public init(_ block: @escaping ()->()) {
        self.block = block
    }
    
    public func run(with data: T? = nil) {
        self.block()
    }
    
}
