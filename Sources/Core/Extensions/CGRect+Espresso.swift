//
//  CGRect+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 9/11/22.
//

import Foundation

public extension CGRect {
    
    var topEdgeRect: CGRect {
        
        return .init(
            x: self.minX,
            y: self.minY,
            width: self.size.width,
            height: .zero
        )
        
    }
    
    var leftEdgeRect: CGRect {
        
        return .init(
            x: self.minX,
            y: self.minY,
            width: .zero,
            height: self.size.height
        )
        
    }
    
    var bottomEdgeRect: CGRect {
        
        return .init(
            x: self.minX,
            y: self.maxY,
            width: self.size.width,
            height: .zero
        )
        
    }
    
    var rightEdgeRect: CGRect {
        
        return .init(
            x: self.maxX,
            y: self.minY,
            width: .zero,
            height: self.size.height
        )
        
    }
    
}
