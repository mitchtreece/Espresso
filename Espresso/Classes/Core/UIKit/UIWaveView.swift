//
//  UIWaveView.swift
//  Espresso
//
//  Created by Mitch Treece on 9/21/19.
//

import UIKit

public class UIWaveView: UIView {
    
    public struct Wave: Hashable {
        
        public var curve: CGFloat  //
        public var speed: CGFloat
        public var height: CGFloat
        public var color: UIColor
        
        public init(curve: CGFloat,
                    speed: CGFloat,
                    height: CGFloat,
                    color: UIColor) {
            
            self.curve = curve
            self.speed = speed
            self.height = height
            self.color = color
            
        }
        
    }
    
    public var waves = [Wave]() {
        didSet {
            setupWaves()
        }
    }
    
    private var layerMap = [Wave: CAShapeLayer]()
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
        
        self.backgroundColor = .groupTableViewBackground
        
    }
    
    private func setupWaves() {
        
        self.displayLink?.invalidate()
        self.displayLink = nil
        
        self.layerMap.values.forEach { $0.removeFromSuperlayer() }
        self.layerMap.removeAll()
        
        var map = [Wave: CAShapeLayer]()
        
        for wave in self.waves {
            
            let layer = self.layer(for: wave)
            map[wave] = layer
            self.layer.addSublayer(layer)
            
        }
        
        self.layerMap = map
        
        //
        
        self.displayLink = CADisplayLink(
            target: self,
            selector: #selector(tick(_:))
        )
        
        self.displayLink!.add(
            to: .current,
            forMode: .common
        )
        
    }
    
    private func layer(for wave: Wave) -> CAShapeLayer {
        
        let layer = CAShapeLayer()
        layer.frame = self.layer.frame
        layer.fillColor = wave.color.cgColor
        return layer
        
    }
    
    @objc private func tick(_ displayLink: CADisplayLink) {
        
        self.offset += 1
        
        let viewSize = CGSize(
            width: self.bounds.width,
            height: self.bounds.height
        )
        
        for (wave, layer) in self.layerMap {
            
            let degree: CGFloat = (.pi / 180)
            
            let path = CGMutablePath()
            path.move(to: CGPoint(x: 0, y: viewSize.height))
            
            var offsetX: CGFloat = 0
            
            while offsetX < viewSize.width {
                                
                let offsetY = (wave.height * sin(offsetX * degree + CGFloat(self.offset) * degree * wave.speed))
                path.addLine(to: CGPoint(x: offsetX, y: offsetY))
                offsetX += 1
                
            }
            
            path.addLine(to: CGPoint(x: viewSize.width, y: viewSize.height))
            path.addLine(to: CGPoint(x: 0, y: viewSize.height))
            path.closeSubpath()
            
            layer.path = path
            layer.fillColor = wave.color.cgColor
            
        }
                
    }
    
}
