//
//  CACornerMask+Espresso.swift
//  Director
//
//  Created by Mitch Treece on 3/18/20.
//

import UIKit

public extension UIRectCorner {
    
    /// A corner mask representation.
    var cornerMask: CACornerMask {
        
        guard !self.contains(.allCorners) else {
            
            return [
                .layerMinXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMaxXMinYCorner,
                .layerMaxXMaxYCorner
            ]
            
        }
        
        var mask: CACornerMask = []
        
        if self.contains(.topLeft) {
            mask.insert(.layerMinXMinYCorner)
        }
        
        if self.contains(.topRight) {
            mask.insert(.layerMaxXMinYCorner)
        }
        
        if self.contains(.bottomLeft) {
            mask.insert(.layerMinXMaxYCorner)
        }
        
        if self.contains(.bottomRight) {
            mask.insert(.layerMaxXMaxYCorner)
        }
        
        return mask
        
    }
    
}
