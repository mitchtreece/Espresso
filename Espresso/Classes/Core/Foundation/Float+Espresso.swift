//
//  Float+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

public extension Float /* Degrees & Radians */ {
    
    /**
     A degree value expressed in radians.
     */
    var degreesToRadians: Float {
        return (self * .pi / 180)
    }
    
    /**
     A radian value expressed in degrees.
     */
    var radiansToDegrees: Float {
        return (self * 180 / .pi)
    }
    
}

public extension CGFloat /* Degrees & Radians */ {
    
    /**
     A radian value for this degree value.
     */
    var degreesToRadians: CGFloat {
        return CGFloat(Float(self).degreesToRadians)
    }
    
    /**
     A degree value for this radian value.
     */
    var radiansToDegrees: CGFloat {
        return CGFloat(Float(self).radiansToDegrees)
    }
    
}

public extension Float /* Aspect Ratio */ {
    
    /**
     The standard aspect ratio (16:9) width for this height.
     */
    var standardAspectRatioWidth: Float {
        guard self > 0 else { return 0 }
        return self * 16/9
    }
    
    /**
     The standard aspect ratio (16:9) height for this width.
     */
    var standardAspectRatioHeight: Float {
        guard self > 0 else { return 0 }
        return self * 9/16
    }
    
}

public extension CGFloat /* Aspect Ratio */ {
    
    /**
     The standard aspect ratio (16:9) width for this height.
     */
    var standardAspectRatioWidth: CGFloat {
        return CGFloat(Float(self).standardAspectRatioWidth)
    }
    
    /**
     The standard aspect ratio (16:9) height for this width.
     */
    var standardAspectRatioHeight: CGFloat {
        return CGFloat(Float(self).standardAspectRatioHeight)
    }
    
}
