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
    
    func associatedObject(forKey key: AnyHashable) -> Any? {
        return self.associatedObjects[key]
    }
    
    func setAssociatedObject(_ object: Any?,
                                    forKey key: AnyHashable) {
        
        if let object = object {
            self.associatedObjects[key] = object
        }
        else {
            removeAssociatedObject(forKey: key)
        }
        
    }
    
    func removeAssociatedObject(forKey key: AnyHashable) {
        self.associatedObjects.removeObject(forKey: key)
    }
    
}

public extension NSObject /* Swizzle */ {
    
    static func swizzle(method name: String,
                        selector: Selector,
                        newSelector: Selector,
                        forClass cls: AnyClass) {
        
        let selector = Selector(name)
        
        guard let method = class_getInstanceMethod(cls, selector) else { return }
        guard let originalMethod = class_getInstanceMethod(cls, selector) else { return }
        guard let swizzledMethod = class_getInstanceMethod(cls, newSelector) else { return }
        
        method_exchangeImplementations(method, originalMethod)
        method_exchangeImplementations(method, swizzledMethod)
        
    }
    
    static func swizzle(method name: String,
                        selector: Selector,
                        newSelector: Selector) {
     
        swizzle(
            method: name,
            selector: selector,
            newSelector: newSelector,
            forClass: Self.self
        )
        
    }
    
}
