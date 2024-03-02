//
//  Image+SwiftUI.swift
//  Espresso
//
//  Created by Mitch Treece on 3/2/24.
//

import SwiftUI
import SFSafeSymbols

@available(iOS 16, *)
public extension Image /* Symbol */ {
    
    /// Creates a new image from a given symbol.
    /// - parameter symbol: The symbol.
    /// - parameter variableValue: An optional value between 0...1
    /// that can be used to customize the symbol's appearance.
    /// - returns: A symbol image.
    static func symbol(_ symbol: SFSymbol,
                       variableValue: Double? = nil) -> Image {
        
        return .init(
            systemSymbol: symbol,
            variableValue: variableValue
        )
        
    }
        
    /// Creates a new image from a given symbol.
    /// - parameter name: The symbol's name.
    /// - parameter variableValue: An optional value between 0...1
    /// that can be used to customize the symbol's appearance.
    /// - returns: A symbol image.
    static func symbol(_ name: String,
                       variableValue: Double? = nil) -> Image {
        
        return .init(
            systemName: name,
            variableValue: variableValue
        )
        
    }
    
}
