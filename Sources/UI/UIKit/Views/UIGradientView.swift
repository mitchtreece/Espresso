//
//  UIGradientView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/12/18.
//

#if canImport(UIKit)

import UIKit

/// `UIView` subclass that draws a gradient as its content.
open class UIGradientView: UIBaseView {
        
    /// Representation of the various gradient color stop modes.
    public enum StopMode: Hashable {
        
        /// A linear color stop mode.
        case linear
        
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
    public var direction: RectDirection = .up {
        didSet {
            update()
        }
    }
    
    /// The gradient's color stop mode; _defaults to linear.
    public var stops: StopMode = .linear {
        didSet {
            update()
        }
    }
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    public override func userInterfaceStyleDidChange() {

        super.userInterfaceStyleDidChange()
        update()

    }
    
    /// Initializes a new `UIGradientView` with colors & a specified direction.
    /// - Parameter colors: The gradient colors; _defaults to [black, clear]_.
    /// - Parameter direction: The gradient direction; _defaults to up_.
    public init(colors: [UIColor] = [.black, .clear],
                direction: RectDirection = .up) {
        
        self.colors = colors
        self.direction = direction
        
        super.init(frame: .zero)
                
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func willAppear() {
        
        super.willAppear()
        
        self.backgroundColor = .clear
        
        update()
        
    }

    /// Updates & draws the view's gradient.
    func update() {
        
        self.gradientLayer.colors = colors.map { $0.cgColor }
        self.gradientLayer.startPoint = self.direction.startPoint
        self.gradientLayer.endPoint = self.direction.endPoint
                
        switch self.stops {
        case .custom(let values):
            
            self.gradientLayer.locations = values
                .map { Float($0) }
                .map { NSNumber(value: $0) }
            
        default: self.gradientLayer.locations = nil
        }
        
    }
    
}

#endif
