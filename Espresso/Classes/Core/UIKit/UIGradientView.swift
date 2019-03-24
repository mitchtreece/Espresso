//
//  UIGradientView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/12/18.
//

import UIKit

/**
 `UIView` subclass that draws a gradient for it's contents.
 */
open class UIGradientView: UIView {
    
    /**
     Representation of the various gradient directions.
     */
    public enum Direction {
        
        /// An upwards direction.
        case up
        
        /// A downwards direction.
        case down
        
        /// A left direction.
        case left
        
        /// A right direction
        case right
        
        /// A custom angle direction (in degrees)
        case angle(CGFloat)
        
        /// A 45-degree angle direction from the bottom left, to the top right.
        case bottomLeftToTopRight
        
        /// A 45-degree angle direction from the bottom right, to the top left.
        case bottomRightToTopLeft
        
    }
    
    private lazy var gradient: CAGradientLayer = {
        return self.layer as! CAGradientLayer
    }()
    
    /**
     The gradient colors; _defaults to [black, clear]_.
     */
    public var colors = [UIColor.black, UIColor.clear] {
        didSet {
            draw()
        }
    }
    
    /**
     The gradient direction; _defaults to up_.
     */
    public var direction: Direction = .up {
        didSet {
            draw()
        }
    }
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    /**
     Initializes a new `UIGradientView` with colors & a specified direction.
     
     - Parameter frame: The view's frame.
     - Parameter colors: The gradient colors.
     - Parameter direction: The gradient direction; _defaults to up_.
     */
    public convenience init(frame: CGRect, colors: [UIColor], direction: Direction = .up) {
        
        self.init(frame: frame)
        self.colors = colors
        self.direction = direction
        self.draw()
        
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.draw()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        self.draw()
        
    }
    
    private func draw() {
        
        gradient.colors = colors.map({ $0.cgColor })
        gradient.startPoint = points(for: direction).start
        gradient.endPoint = points(for: direction).end
        
    }
    
    private func points(for direction: Direction) -> (start: CGPoint, end: CGPoint) {
        
        switch direction {
        case .up: return (CGPoint(x: 0.5, y: 1), CGPoint(x: 0.5, y: 0))
        case .down: return (CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1))
        case .left: return (CGPoint(x: 1, y: 0.5), CGPoint(x: 0, y: 0.5))
        case .right: return (CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5))
        case .angle(let angle): return _gradientPointsForAngle(angle)
        case .bottomLeftToTopRight: return _gradientPointsForAngle(45)
        case .bottomRightToTopLeft: return _gradientPointsForAngle(135)
        }
        
    }
    
    private func _gradientPointsForAngle(_ angle: CGFloat) -> (start: CGPoint, end: CGPoint) {
        
        let end = _pointsForAngle(angle)
        let start = _oppositePoint(end)
        let p0 = _translatePointToGradientSpace(start)
        let p1 = _translatePointToGradientSpace(end)
        return (p0, p1)
        
    }
    
    private func _pointsForAngle(_ angle: CGFloat) -> CGPoint {
        
        let radians = angle.degreesToRadians
        var x = cos(radians)
        var y = sin(radians)
        
        // (x, y) is in terms of unit circle
        // Extrapolate to unit square for full vector length
        
        if abs(x) > abs(y) {
            
            // Extrapolate x to unit length
            
            x = (x > 0) ? 1 : -1
            y = x * tan(radians)
            
        }
        else {
            
            // Extrapolate y to unit length
            
            y = (y > 0) ? 1 : -1
            x = y / tan(radians)
            
        }
        
        return CGPoint(x: x, y: y)
        
    }
    
    private func _oppositePoint(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: -point.x, y: -point.y)
    }
    
    private func _translatePointToGradientSpace(_ point: CGPoint) -> CGPoint {
        
        // Input point is in signed unit space: (-1, -1) to (1, 1)
        // Convert to gradient space: (0, 0) to (1, 1) with flipped Y-axis
        
        return CGPoint(
            x: (point.x + 1) * 0.5,
            y: 1 - (point.y + 1) * 0.5
        )
        
    }
    
}
