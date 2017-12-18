//
//  Stack.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import Foundation

public class Stack<T> {
    
    private var size: UInt?
    private var objects = [T]()
    
    public var count: Int {
        return objects.count
    }
    
    public var isEmpty: Bool {
        return objects.isEmpty
    }
    
    public var isFull: Bool {
        
        guard let size = size else { return false }
        return (objects.count == size)
        
    }
    
    public var topItem: T? {
        return objects.last
    }
    
    public init(size: UInt?) {
        self.size = size
    }
    
    public convenience init() {
        self.init(size: nil)
    }
    
    public func push(_ object: T) {
        
        guard !isFull else { return }
        objects.append(object)
        
    }
    
    @discardableResult
    public func pop() -> T? {
        
        guard !isEmpty else { return nil }
        return objects.removeLast()
        
    }
    
    public func peek() -> T? {
        return topItem
    }
    
}

extension Stack: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        
        let className = String(describing: T.self)
        var string = "<Stack(\(className))> ["
        
        for object in objects.reversed() {
            string += "\n\t\(object),"
        }
        
        string.removeLast()
        string += "\n]"
        return string
        
    }
    
    public var debugDescription: String {
        return description
    }
    
}
