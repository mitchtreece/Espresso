//
//  MemoryAddress.swift
//  Espresso
//
//  Created by Mitch Treece on 2/27/24.
//

import Foundation

/// A memory-address representation of a given object.
public struct MemoryAddress<T> {

    /// The memory address's integer value.
    public let intValue: Int
    
    public init(of structInstance: UnsafePointer<T>) {
        self.intValue = Int(bitPattern: structInstance)
    }
    
    /// Gets the memory address's string value.
    /// - parameter trim: Flag indicating if leading zeros should be truncated.
    /// - returns: A memory address string.
    public func stringValue(trim: Bool = false) -> String {
        
        let length = 2 + 2 * MemoryLayout<UnsafeRawPointer>.size
        let untrimmed = String(format: "%0\(length)p", self.intValue)
        
        guard trim else {
            return untrimmed
        }
        
        let components = untrimmed
            .components(separatedBy: "x")
        
        guard components.count == 2 else {
            return untrimmed
        }
        
        var trimmed = "0x"
        var hasSeenNonZero = false
        
        for character in components.last! {
            
            if character == "0" && !hasSeenNonZero {
                continue
            }
            
            hasSeenNonZero = true
            trimmed += String(character)
            
        }
        
        return trimmed
        
    }
    
}

public extension MemoryAddress where T: AnyObject {
    
    init(of classInstance: T) {
        
        self.intValue = unsafeBitCast(
            classInstance,
            to: Int.self
        )
                
    }
    
}

extension MemoryAddress: CustomStringConvertible {
    
    public var description: String {
        return stringValue()
    }
    
}
