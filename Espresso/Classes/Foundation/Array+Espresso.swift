//
//  Array+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import Foundation

public extension Array where Element: Operation {
    
    public func completion(block: @escaping ()->()) {
        
        let operation = BlockOperation(block: block)
        self.forEach { [unowned operation] in operation.addDependency($0) }
        OperationQueue().addOperation(operation)
        
    }
    
}
