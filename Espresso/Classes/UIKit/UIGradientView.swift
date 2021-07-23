//
//  UIGradientView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/12/18.
//

import UIKit

/// `UIView` subclass that draws a gradient as its content.
open class UIGradientView: UIBaseView {
    
    /// Representation of the various gradient directions.
    public enum Direction {
        
        /// An upwards direction.
        case up
        
        /// A downwards direction.
        case down
        
        /// A left direction.
        case left
        
        /// A right direction
        case right
        
        /// A custom angle direction (degrees)
        case angle(CGFloat)
        
        /// A 45-degree angle direction from the bottom left, to the top right.
        case bottomLeftToTopRight
        
        /// A 45-degree angle direction from the bottom right, to the top left.
        case bottomRightToTopLeft
        
    }
    
    /// Representation of the various gradient color stop modes.
    public enum StopMode: Hashable {
        
        /// An equal color stop mode.
        case equal
        
        /// A custom color stop mode.
        case custom([CGFloat])
        
    }
    
    /// The view's backing `CAGradientLayer`.
    public private(set) lazy var gradientLayer: CAGradientLayer = {
        return self.layer as! CAGradientLayer
    }()
    
    /// The gradient colors; _defaults to [black, clear]_.
    public var colors: [UIColor] = [.black, .clear] {
        didSet {
            update()
        }
    }
    
    /// The gradient direction; _defaults to up_.
    public var direction: Direction = .up {
        didSet {
            update()
        }
    }
    
    /// The gradient's color stop mode; _defaults to equal_.
    public var stops: StopMode = .equal {
        didSet {
            update()
        }
    }
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    @available(iOS 12, *)
    public override func userInterfaceStyleDidChange() {
        super.userInterfaceStyleDidChange()
        update()
    }
    
    /// Initializes a new `UIGradientView` with colors & a specified direction.
    /// - Parameter frame: The view's frame.
    /// - Parameter colors: The gradient colors.
    /// - Parameter direction: The gradient direction; _defaults to up_.
    public convenience init(frame: CGRect,
                            colors: [UIColor],
                            direction: Direction = .up) {
        
        self.init(frame: frame)
        self.colors = colors
        self.direction = direction
        
        update()
        
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        update()
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        self.backgroundColor = .clear
        
        update()
        
    }
    
    /// Updates & draws the view's gradient.
    func update() {
        
        self.gradientLayer.colors = colors.map({ $0.cgColor })
        self.gradientLayer.startPoint = points(for: self.direction).start
        self.gradientLayer.endPoint = points(for: self.direction).end
                
        switch self.stops {
        case .custom(let values):
            
            self.gradientLayer.locations = values
                .map { Float($0) }
                .map { NSNumber(value: $0) }
            
        default: self.gradientLayer.locations = nil
        }
        
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
        
        let radians = angle.convertAngle(to: .radian)
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
