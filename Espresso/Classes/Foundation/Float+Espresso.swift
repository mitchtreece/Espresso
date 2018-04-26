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
    
    var standardAspectRatioWidth: Float {
        guard self > 0 else { return 0 }
        return self * 16/9
    }
    
    var standardAspectRatioHeight: Float {
        guard self > 0 else { return 0 }
        return self * 9/16
    }
    
}

extension CGFloat {
    
    var standardAspectRatioWidth: CGFloat {
        return CGFloat(Float(self).standardAspectRatioWidth)
    }
    
    var standardAspectRatioHeight: CGFloat {
        return CGFloat(Float(self).standardAspectRatioHeight)
    }
    
}
