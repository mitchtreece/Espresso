//
//  PlaceholderRepresentable.swift
//  Espresso
//
//  Created by Mitch Treece on 2/8/24.
//

import Foundation

/// Representation of the various placeholder sizes.
public enum PlaceholderSize {
    
    /// A small placeholder size.
    case small
    
    /// A medium placeholder size.
    case medium
    
    /// A large placeholder size.
    case large
    
    /// An extra-large placeholder size.
    case extraLarge
    
    /// A custom placeholder size.
    case custom(Int)
    
}

/// Protocol describing the characteristics of something
/// that can be represented as a placeholder.
public protocol PlaceholderRepresentable {
    
    /// Gets a placeholder representation of this type.
    /// - parameter size: The placeholder size.
    /// - returns: A placeholder representation of this type.
    static func placeholder(_ size: PlaceholderSize) -> Self
    
}

public extension PlaceholderRepresentable {
    
    /// A placeholder representation of this type.
    static var placeholder: Self {
        return placeholder(.medium)
    }
    
}

extension String: PlaceholderRepresentable {
    
    public static func placeholder(_ size: PlaceholderSize) -> String {
        
        let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        var length: Int = 0
        
        switch size {
        case .small: length = 8
        case .medium: length = 32
        case .large: length = 128
        case .extraLarge: length = 256
        case .custom(let s): length = s
        }
        
        return String((0..<length)
            .map { _ in characters.randomElement() ?? "?" })
        
    }
    
}

extension Double: PlaceholderRepresentable {
    
    public static func placeholder(_ size: PlaceholderSize) -> Double {
        
        var count: Int = 1
                
        switch size {
        case .small: count = 1
        case .medium: count = 3
        case .large: count = 6
        case .extraLarge: count = 9
        case .custom(let s): count = max(0, min(s, 15)) // 0...15
        }
        
        var value: Int = 1
        
        for _ in 0..<count {
            value *= 10
        }
        
        return Double(value)
                
    }
    
}

extension Float: PlaceholderRepresentable {
    
    public static func placeholder(_ size: PlaceholderSize) -> Float {
        return Float(Double.placeholder(size))
    }
    
}

extension CGFloat: PlaceholderRepresentable {
    
    public static func placeholder(_ size: PlaceholderSize) -> CGFloat {
        return CGFloat(Float.placeholder(size))
    }
    
}

extension Int: PlaceholderRepresentable {
    
    public static func placeholder(_ size: PlaceholderSize) -> Int {
        return Int(Double.placeholder(size))
    }
    
}
