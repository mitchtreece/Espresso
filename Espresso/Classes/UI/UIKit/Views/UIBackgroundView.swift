//
//  UIBackgroundView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/28/22.
//

import UIKit

public class UIBackgroundView: UIBaseView {
    
    public enum Style {
        
        case color(UIColor)
        case blur(UIBlurEffect.Style)
        case tintedBlur(UIBlurEffect.Style, tint: UIColor, tintAlpha: CGFloat)
        
    }
    
    public var style: Style = .color(.systemBackground) {
        didSet {
            layout(for: style)
        }
    }
    
    public private(set) var blurView: UIVisualEffectView!

    public init(style: Style = .color(.systemBackground)) {
        
        self.style = style
        super.init(frame: .zero)
        
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func willSetup() {
        
        super.willSetup()
        
        self.backgroundColor = .clear
        self.clipsToBounds = true
        
        self.blurView = UIVisualEffectView()
        self.blurView.clipsToBounds = true
        addSubview(self.blurView)
        self.blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        layout(for: self.style)
        
    }
    
    // MARK: Private
    
    private func layout(for style: Style) {
        
        switch style {
        case .color(let color):
            
            self.backgroundColor = color
            self.blurView.isHidden = true
            
        case .blur(let blurStyle):
            
            self.backgroundColor = .clear
                        
            self.blurView.effect = UIBlurEffect(style: blurStyle)
            self.blurView.isHidden = false
            
        case .tintedBlur(let blurStyle, let tint, let tintAlpha):
            
            self.backgroundColor = tint.withAlphaComponent(tintAlpha)
                        
            self.blurView.effect = UIBlurEffect(style: blurStyle)
            self.blurView.isHidden = false

        }
        
    }
    
}
