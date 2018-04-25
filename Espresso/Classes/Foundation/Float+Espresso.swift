//
//  Float+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

// MARK: Random

public extension Float {
    
    // FIGURE THIS STUFF OUT
    
    // 0...((2^32)–1) [whole numbers]
    static var random: Float {
        return Float(arc4random() / UInt32.max)
    }
    
    // 0...max [whole numbers]
    static func random(_ max: Float) -> Float {
        return Float(arc4random_uniform(UInt32(max)))
    }
    
    // l...u [whole numbers]
    static func randomInRange(_ range: Range<Float>) -> Float {
        
        let max = (range.upperBound - range.lowerBound + 1)
        let random = Float.random(max)
        return (random + range.lowerBound)
        
    }
    
    // 0.0...1.0 [decimal numbers]
    static var randomToOne: Float {
        return Float(drand48())
    }
    
}

public extension CGFloat {
    
    static var random: CGFloat {
        return CGFloat(Float.random)
    }
    
    static func random(_ max: CGFloat) -> CGFloat {
        return CGFloat(Float.random(Float(max)))
    }
    
    static func randomInRange(_ range: Range<CGFloat>) -> CGFloat {
        
        let max = (Float(range.upperBound) - Float(range.lowerBound) + 1)
        let random = CGFloat(Float.random(max))
        return (random + range.lowerBound)
        
    }
    
    static var randomToOne: CGFloat {
        return CGFloat(drand48())
    }
    
}

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
