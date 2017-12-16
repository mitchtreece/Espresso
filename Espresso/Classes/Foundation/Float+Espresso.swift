//
//  Float+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

// MARK: Degrees & Radians

public extension Float {
    
    public var degreesToRadians: Float {
        return (self * .pi / 180)
    }
    
    public var radiansToDegrees: Float {
        return (self * 180 / .pi)
    }
    
}

public extension CGFloat {
    
    public var degreesToRadians: CGFloat {
        return CGFloat(Float(self).degreesToRadians)
    }
    
    public var radiansToDegrees: CGFloat {
        return CGFloat(Float(self).radiansToDegrees)
    }
    
}

// MARK: Aspect Ratio

extension Float {
    
    var aspectRatioWidth: Float {
        guard self > 0 else { return 0 }
        return self * 16/9
    }
    
    var aspectRatioHeight: Float {
        guard self > 0 else { return 0 }
        return self * 9/16
    }
    
}

extension CGFloat {
    
    var aspectRatioWidth: CGFloat {
        return CGFloat(Float(self).aspectRatioWidth)
    }
    
    var aspectRatioHeight: CGFloat {
        return CGFloat(Float(self).aspectRatioHeight)
    }
    
}
