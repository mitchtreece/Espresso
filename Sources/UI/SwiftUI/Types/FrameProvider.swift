//
//  FrameProvider.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/24.
//

import UIKit
import SwiftUI

/// Representation of the various types of frame providers.
public enum FrameProvider {
    
    case geometry(
        GeometryProxy,
        coordinateSpace: CoordinateSpace = .global
    )
    
    case frame(CGRect)
    
    case screen
    
    public var frame: CGRect {
        
        switch self {
        case .geometry(let proxy, let space):
            
            return proxy.frame(in: space)
            
        case .frame(let frame):
            
            return frame
            
        case .screen:
            
            // TODO: Find a better way to get the screen
            // geometry outside of a view. Accessing `UIScreen`
            // geometry directly is deprecated.
            
            return UIScreen.main.bounds
            
        }
        
    }
    
}
