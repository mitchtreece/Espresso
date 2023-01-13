//
//  UIParallaxView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/20/22.
//

import UIKit

open class UIParallaxView: UIBaseView {
    
    public struct ParallaxLayer {
        
        public let view: UIView
        public let parallax: CGFloat
        public let offset: CGVector
        public let mask: UIImage?
        
        public init(view: UIView,
                    parallax: CGFloat,
                    offset: CGVector = .zero,
                    mask: UIImage? = nil) {
            
            self.view = view
            self.parallax = parallax
            self.offset = offset
            self.mask = mask
            
        }
        
    }
    
    private var views = [UIView]()
    
    public init(layers: [ParallaxLayer] = []) {
        
        super.init(frame: .zero)
        layout(for: layers)
        
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func willSetup() {
        
        super.willSetup()
        
        self.backgroundColor = .clear
        self.clipsToBounds = false

    }
    
    public func setParallaxLayers(_ layers: [ParallaxLayer]) {
        layout(for: layers)
    }

    public func addParallaxLayer(_ layer: ParallaxLayer) {
        
        layoutIfNeeded()
                
        guard let maskImage = layer.mask else {
            
            let view = layer.view
            view.frame = self.bounds
            self.addSubview(view)
            view.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(layer.offset.dy)
                make.left.equalToSuperview().offset(layer.offset.dx)
                make.width.height.equalToSuperview()
            }
            
            if layer.parallax > 0 {

                view.addParallaxMotionEffect(movement: .init(
                    dx: layer.parallax,
                    dy: layer.parallax
                ))

            }
                        
            self.views.append(view)
            return
            
        }
        
        let maskView = UIImageView()
        maskView.frame = self.bounds
        maskView.backgroundColor = .clear
        maskView.image = maskImage
        maskView.contentMode = .scaleAspectFit
        
        let containerView = UIView()
        containerView.frame = self.bounds
        containerView.mask = maskView
        self.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let contentView = layer.view
        contentView.frame = self.bounds
        containerView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(layer.offset.dy)
            make.left.equalToSuperview().offset(layer.offset.dx)
            make.width.height.equalToSuperview()
        }
        
        if layer.parallax > 0 {

            contentView.addParallaxMotionEffect(movement: .init(
                dx: layer.parallax,
                dy: layer.parallax
            ))

        }
                
        self.views.append(containerView)
        
    }
    
    public func removeParallaxLayerAtIndex(_ index: Int) {
        
        guard let view = self.views[safe: index] else { return }
        
        view.removeFromSuperview()
        
        self.views.remove(at: index)
        
    }
    
    public func removeAllParallaxLayers() {
        
        self.views
            .forEach { $0.removeFromSuperview() }
        
        self.views.removeAll()
        
    }
    
    // MARK: Private
    
    private func layout(for layers: [ParallaxLayer]) {
        
        removeAllParallaxLayers()
        
        layers
            .forEach { addParallaxLayer($0) }
        
    }
        
}
