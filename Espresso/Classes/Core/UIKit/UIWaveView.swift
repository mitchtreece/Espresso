//
//  UIWaveView.swift
//  Espresso
//
//  Created by Mitch Treece on 9/21/19.
//

import UIKit

/// `UIView` subclass that draws & animates fluid waves.
public class UIWaveView: UIView {
    
    /// Representation of the various wave types.
    public enum Wave: Hashable {
        
        public static func == (lhs: UIWaveView.Wave, rhs: UIWaveView.Wave) -> Bool {
            
            switch lhs {
            case .solid(let l_height, let l_inset, let l_speed, let l_color):
                
                switch rhs {
                case .solid(let r_height, let r_inset, let r_speed, let r_color):
                    
                    return (
                        (l_height == r_height) &&
                        (l_inset == r_inset) &&
                        (l_speed == r_speed) &&
                        (l_color == r_color)
                    )
                    
                default: return false
                }
            
            case .gradient(let l_height, let l_inset, let l_speed, let l_colors, let l_dist):
                
                switch rhs {
                case .gradient(let r_height, let r_inset, let r_speed, let r_colors, let r_dist):
                    
                    return (
                        (l_height == r_height) &&
                        (l_inset == r_inset) &&
                        (l_speed == r_speed) &&
                        (l_colors == r_colors) &&
                        (l_dist == r_dist)
                    )
                    
                default: return false
                }
                
            }
            
        }
        
        public func hash(into hasher: inout Hasher) {
            
            switch self {
            case .solid(let height, let inset, let speed, let color):
                
                hasher.combine(height)
                hasher.combine(inset)
                hasher.combine(speed)
                hasher.combine(color)
                
            case .gradient(let height, let inset, let speed, let colors, _):
                
                hasher.combine(height)
                hasher.combine(inset)
                hasher.combine(speed)
                hasher.combine(colors)
                
            }
            
        }
        
        /// A wave drawn with a solid color.
        ///
        /// **height**: The height of the wave inset from view's top.
        ///
        /// **inset**: The amount to inset the wave from the view's top; _defaults to nil_.
        ///
        /// **speed**: The wave's movement speed.
        ///
        /// **color**: The wave's color.
        case solid(
            height: CGFloat,
            inset: CGFloat? = nil,
            speed: CGFloat,
            color: UIColor
        )
        
        /// A wave drawn with a gradient.
        ///
        /// **height**: The height of the wave inset from view's top.
        ///
        /// **inset**: The amount to inset the wave from the view's top; _defaults to nil_.
        ///
        /// **speed**: The wave's movement speed.
        ///
        /// **colors**: The wave's gradient colors.
        ///
        /// **stops**: The wave's gradient stops.
        case gradient(
            height: CGFloat,
            inset: CGFloat? = nil,
            speed: CGFloat,
            colors: [UIColor],
            stops: UIGradientView.Stops
        )
        
    }
    
    /// The view's waves.
    public var waves = [Wave]() {
        didSet {
            setupWaves()
        }
    }
    
    private var layerMap = [Wave: CALayer]()
    private var offset: Int = 0
    
    private var displayLink: CADisplayLink?
    
    /// Initializes a `UIWaveView` with waves.
    /// - parameter waves: The view's waves.
    public convenience init(waves: [Wave]) {
        
        self.init(frame: .zero)
        self.waves = waves
        setupWaves()
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        self.backgroundColor = .clear
    }
    
    private func setupWaves() {
        
        self.displayLink?.invalidate()
        self.displayLink = nil
        
        self.layerMap.values.forEach { $0.removeFromSuperlayer() }
        self.layerMap.removeAll()
        
        var map = [Wave: CALayer]()
                
        self.waves.forEach {
            
            let layer = self.layer(for: $0)
            map[$0] = layer
            self.layer.addSublayer(layer)
                        
        }
        
        self.layerMap = map
        
        self.displayLink = CADisplayLink(
            target: self,
            selector: #selector(tick(_:))
        )

        self.displayLink!.add(
            to: .current,
            forMode: .common
        )
        
    }
    
    private func layer(for wave: Wave) -> CALayer {
        
        switch wave {
        case .solid(_, _, _, let color):
            
            let layer = CAShapeLayer()
            layer.frame = self.bounds
            layer.fillColor = color.cgColor
            return layer
        
        case .gradient(_, _, _, let colors, let stops):
            
            let gradient = UIGradientView(frame: self.bounds)
            gradient.colors = colors
            gradient.direction = .up
            gradient.stops = stops
            return gradient.gradientLayer
            
        }
        
    }
    
    @objc private func tick(_ displayLink: CADisplayLink) {
        
        self.offset += 1
        
        let viewSize = CGSize(
            width: self.bounds.width,
            height: self.bounds.height
        )
        
        for (wave, layer) in self.layerMap {
            
            let angle: CGFloat = (.pi / 180)
            let _offset = CGFloat(self.offset)
            
            var waveHeight: CGFloat = 0
            var waveInset: CGFloat = 0
            var waveSpeed: CGFloat = 0
            
            switch wave {
            case .solid(let height, let inset, let speed, _):
                
                waveHeight = height
                waveInset = inset ?? 0
                waveSpeed = speed
                
            case .gradient(let height, let inset, let speed, _, _):
                
                waveHeight = height
                waveInset = inset ?? 0
                waveSpeed = speed
                
            }
            
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 0, y: viewSize.height))
            
            var xOffset: CGFloat = 0
            
            while xOffset < viewSize.width {
                
                let depth = (waveHeight / 2)
                let waveTopInset = waveInset
                let yOffset = ((depth * sin(xOffset * angle + _offset * angle * waveSpeed) + depth) + waveTopInset)
                
                path.addLine(to: CGPoint(x: xOffset, y: yOffset))
                xOffset += 1
                
            }
            
            path.addLine(to: CGPoint(x: viewSize.width, y: viewSize.height))
            path.addLine(to: CGPoint(x: 0, y: viewSize.height))
            path.closeSubpath()
            
            layer.frame = self.bounds
            
            if let shapeLayer = layer as? CAShapeLayer {
                shapeLayer.path = path
            }
            else if let gradientLayer = layer as? CAGradientLayer {
                
                if let mask = gradientLayer.mask as? CAShapeLayer {
                    mask.path = path
                }
                else {
                    
                    let mask = CAShapeLayer()
                    mask.frame = layer.bounds
                    mask.path = path
                    layer.mask = mask
                    
                }
                
            }
            
        }
                
    }
    
}
