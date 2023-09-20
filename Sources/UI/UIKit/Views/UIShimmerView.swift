//
//  UIShimmerView.swift
//  Espresso
//
//  Created by Mitch Treece on 5/26/23.
//

import UIKit
import Espresso

open class UIShimmerView: UIBaseView {
    
    private var gradientLayer: CAGradientLayer!
    
    /// The view's shimmer color.
    public var shimmerColor: UIColor = .systemGray6 {
        didSet {
            updateColors()
        }
    }
    
    /// The view's shimmer direction.
    public var shimmerDirection: RectDirection = .right {
        didSet {
            updateDirection()
        }
    }
    
    /// The view's shimmer animation duration.
    public var shimmerDuration: TimeInterval = 1 {
        didSet {
            updateAnimation()
        }
    }
    
    /// Flag indicating if the view's shimmer animation
    /// is currently active.
    private(set) var isAnimating: Bool = false
    
    private let animationKeyPath = "locations"
    
    public init() {
        
        super.init(frame: .zero)
        setup()
        
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setup()
        
    }
    
    open override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.gradientLayer
            .frame = self.bounds
        
    }

    /// Starts the view's shimmer animation.
    public func start() {
        
        guard !self.isAnimating else { return }
        
        addAnimation()
        
        self.isAnimating = true
        
    }
    
    /// Stops the view's shimmer animation.
    public func stop() {
        
        guard self.isAnimating else { return }
        
        removeAnimation()
        
        self.isAnimating = false
        
    }
    
    public override func userInterfaceStyleDidChange() {
        
        super.userInterfaceStyleDidChange()
        updateColors()
        
    }
    
    // MARK: Private
    
    private func setup() {
                
        self.backgroundColor = .systemGray5
        self.layer.masksToBounds = true
                
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000) // fix animation
        self.gradientLayer.locations = [0.0, 0.5, 1.0]
        self.gradientLayer.zPosition = .greatestFiniteMagnitude
        self.layer.addSublayer(self.gradientLayer)
        
        updateColors()
        updateDirection()
        start()
        
    }
    
    private func updateColors() {
        
        self.gradientLayer.colors = [
            self.backgroundColor!.cgColor,
            self.shimmerColor.cgColor,
            self.backgroundColor!.cgColor
        ]
        
    }
    
    private func updateDirection() {
        
        self.gradientLayer
            .startPoint = self.shimmerDirection.startPoint
        
        self.gradientLayer
            .endPoint = self.shimmerDirection.endPoint
        
    }
    
    private func updateAnimation() {
        
        removeAnimation()
        addAnimation()
        
    }
    
    private func addAnimation() {
        
        let animation = CABasicAnimation(keyPath: self.animationKeyPath)
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = CFTimeInterval(self.shimmerDuration)

        self.gradientLayer.add(
            animation,
            forKey: animation.keyPath
        )
        
    }
        
    private func removeAnimation() {
        
        self.gradientLayer
            .removeAnimation(forKey: self.animationKeyPath)
        
    }
    
}
