//
//  UIWaveView.swift
//  Espresso
//
//  Created by Mitch Treece on 9/21/19.
//

import UIKit

public class UIWaveView: UIView {
    
    public class Wave: Hashable {
        
        public static func == (lhs: UIWaveView.Wave, rhs: UIWaveView.Wave) -> Bool {
            return lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(self.id)
        }
        
        private var id: UUID
        
        public var height: CGFloat
        public var inset: CGFloat?
        public var speed: CGFloat
        public var color: UIColor
        
        public init(height: CGFloat,
                    inset: CGFloat? = nil,
                    speed: CGFloat,
                    color: UIColor) {
            
            self.id = UUID()
            self.height = height
            self.inset = inset
            self.speed = speed
            self.color = color
            
        }
        
    }
    
    public class GradientWave: Wave {
        
        public var colors: [UIColor]
        
        public init(height: CGFloat,
                    inset: CGFloat? = nil,
                    speed: CGFloat,
                    colors: [UIColor]) {
            
            self.colors = colors
            
            super.init(
                height: height,
                inset: inset,
                speed: speed,
                color: .clear
            )
            
        }
        
    }
    
    public var waves = [Wave]() {
        didSet {
            setupWaves()
        }
    }
    
    private var layerMap = [Wave: CALayer]()
    private var offset: Int = 0
    
    private var displayLink: CADisplayLink?
    
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
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
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
        
        if let gradientWave = wave as? GradientWave {
            
            let layer = CAGradientLayer()
            layer.frame = self.bounds
            layer.colors = gradientWave.colors.map { $0.cgColor }
            layer.startPoint = CGPoint(x: 0.5, y: 1)
            layer.endPoint = CGPoint(x: 0.5, y: 0)
            return layer
            
        }
        else {
            
            let layer = CAShapeLayer()
            layer.frame = self.bounds
            layer.fillColor = wave.color.cgColor
            return layer
            
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
            
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 0, y: viewSize.height))
            
            var xOffset: CGFloat = 0
            
            while xOffset < viewSize.width {
                
                let depth = (wave.height / 2)
                let waveTopInset = wave.inset ?? 0
                let yOffset = ((depth * sin(xOffset * angle + _offset * angle * wave.speed) + depth) + waveTopInset)
                
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
