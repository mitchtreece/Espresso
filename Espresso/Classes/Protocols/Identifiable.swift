//
//  Identifiable.swift
//  Espresso
//
//  Created by Mitch Treece on 1/27/18.
//

import Foundation

public protocol Identifiable {
    
    var identifier: String { get }
    
}

public extension Identifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UIView: Identifiable {
    
    private struct AssociatedKeys {
        static var identifier: UInt8 = 0
    }
    
    public var identifier: String {
        
        get {
            
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.identifier) as? String else {
                
                let uuid = UUID().uuidString
                self.identifier = uuid
                return uuid
                
            }
            
            return value
            
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.identifier, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
    
}
