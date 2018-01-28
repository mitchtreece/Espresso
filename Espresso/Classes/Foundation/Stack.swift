//
//  Stack.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import Foundation

public class Stack<T> {
    
    private var objects = [T]()
    
    public var count: Int {
        return objects.count
    }
    
    public var isEmpty: Bool {
        return objects.isEmpty
    }
    
    public var topItem: T? {
        return objects.last
    }
    
    public init() {
        //
    }
    
    public convenience init(items: [T]) {
        
        self.init()
        self.objects.append(contentsOf: items)
        
    }
    
    public func push(_ object: T) {
        objects.append(object)
    }
    
    public func peek() -> T? {
        return topItem
    }
    
    @discardableResult
    public func pop() -> T? {
        
        guard !isEmpty else { return nil }
        return objects.removeLast()
        
    }
    
}

extension Stack: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        
        let className = String(describing: T.self)
        var string = "<Stack(\(className))> ["
        
        for i in 0..<objects.count {
            let obj = objects.reversed()[i]
            string += "\n\t\(i): \(obj),"
        }
        
        string.removeLast()
        string += "\n]"
        return string
        
    }
    
    public var debugDescription: String {
        return description
    }
    
}
