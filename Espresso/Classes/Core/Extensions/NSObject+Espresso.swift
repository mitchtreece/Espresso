//
//  NSObject+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 9/11/22.
//

import Foundation

public extension NSObject /* Associated Object */ {
    
    private struct AssociatedKeys {
        static var associatedObjects: UInt8 = 0
    }
    
    /// The object's associated object dictionary.
    var associatedObjects: NSMutableDictionary {
        
        if let objects = objc_getAssociatedObject(self, &AssociatedKeys.associatedObjects) as? NSMutableDictionary {
            return objects
        }
        else {
            
            let objects = NSMutableDictionary()
            objc_setAssociatedObject(self, &AssociatedKeys.associatedObjects, objects, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return objects
            
        }
        
    }
    
    /// Gets an associated object for a given key.
    ///
    /// - parameter key: An object association key.
    /// - returns: The associated object, or `nil`.
    func associatedObject(forKey key: AnyHashable) -> Any? {
        return self.associatedObjects[key]
    }
    
    /// Sets an associated object for a given key.
    ///
    /// - parameter object: The associated object.
    /// - parameter key: An object association key.
    func setAssociatedObject(_ object: Any?,
                             forKey key: AnyHashable) {
        
        if let object = object {
            self.associatedObjects[key] = object
        }
        else {
            self.associatedObjects.removeObject(forKey: key)
        }
        
    }
    
}

public extension NSObject /* Swizzle */ {
    
    /// Exchanges a classes method implementation with a new one.
    ///
    /// - parameter method: The method name.
    /// - parameter selector: The original selector.
    /// - parameter newSelector: The new selector.
    /// - parameter target: The target class.
    static func swizzle(method name: String,
                        selector: Selector,
                        newSelector: Selector,
                        target cls: AnyClass) {
        
        let selector = Selector(name)
        
        guard let method = class_getInstanceMethod(cls, selector) else { return }
        guard let originalMethod = class_getInstanceMethod(cls, selector) else { return }
        guard let swizzledMethod = class_getInstanceMethod(cls, newSelector) else { return }
        
        method_exchangeImplementations(method, originalMethod)
        method_exchangeImplementations(method, swizzledMethod)
        
    }
    
    /// Exchanges a method implementation with a new one.
    ///
    /// - parameter method: The method name.
    /// - parameter selector: The original selector.
    /// - parameter newSelector: The new selector.
    static func swizzle(method name: String,
                        selector: Selector,
                        newSelector: Selector) {
     
        swizzle(
            method: name,
            selector: selector,
            newSelector: newSelector,
            target: Self.self
        )
        
    }
    
}
