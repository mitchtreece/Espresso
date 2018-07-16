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
    
    private func points(for direction: Direction) -> (start: CGPoint, end: CGPoint) {
        
        switch direction {
        case .up: return (CGPoint(x: 0.5, y: 1), CGPoint(x: 0.5, y: 0))
        case .down: return (CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1))
        case .left: return (CGPoint(x: 1, y: 0.5), CGPoint(x: 0, y: 0.5))
        case .right: return (CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5))
        }
        
    }
    
    private func draw() {
        
        gradient.colors = colors.map({ $0.cgColor })
        gradient.startPoint = points(for: direction).start
        gradient.endPoint = points(for: direction).end
        
    }
    
}
