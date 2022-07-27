//
//  UIBarView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import UIKit
import SnapKit

open class UIBarView: UIBaseView {
    
    public enum Background {
        
        case color(UIColor)
        case gradient([UIColor])
        case blur(UIBlurEffect.Style)
        
    }
    
    public enum Divider {
        
        case none
        case hairline
        case darkGradient
        case lightGradient
        
    }
    
    public private(set) var backgroundContentView: UIView!
    private var backgroundColorView: UIView!
    private var backgroundGradientView: UIGradientView!
    private var backgroundBlurView: UIVisualEffectView!
    
    private var safeAreaView: UIView!
    private var safeAreaViewHeightConstraint: Constraint!
    
    public private(set) var contentView: UIView!
    
    private var dividerHairlineView: UIHairlineView!
    private var dividerGradientView: UIGradientView!
    
    public var anchor: Edge.Vertical = .top {
        didSet {
            updateAnchor()
        }
    }
    
    public var background: Background = .color(.systemBackground) {
        didSet {
            updateBackground()
        }
    }
    
    public var divider: Divider = .none {
        didSet {
            updateDivider()
        }
    }
    
    public var dividerAnchor: Edge.Vertical = .bottom {
        didSet {
            updateDivider()
        }
    }

    private var backgroundView: UIView {
        
        switch self.background {
        case .color: return self.backgroundColorView
        case .gradient: return self.backgroundGradientView
        case .blur: return self.backgroundBlurView
        }
        
    }
    
    open override func setupView() {
                
        super.setupView()
        
        // Background
        
        self.backgroundColor = .clear
        
        self.backgroundContentView = UIView()
        addSubview(self.backgroundContentView)
        self.backgroundContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.backgroundColorView = UIView()
        self.backgroundContentView.addSubview(self.backgroundColorView)
        self.backgroundColorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.backgroundGradientView = UIGradientView()
        self.backgroundGradientView.colors = [.black, .clear]
        self.backgroundGradientView.isHidden = true
        self.backgroundContentView.addSubview(self.backgroundGradientView)
        self.backgroundGradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.backgroundBlurView = UIVisualEffectView()
        self.backgroundBlurView.isHidden = true
        self.backgroundContentView.addSubview(self.backgroundBlurView)
        self.backgroundBlurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Safe Area
        
        self.safeAreaView = UIView()
        self.safeAreaView.backgroundColor = .clear
        addSubview(self.safeAreaView)
        
        // Content
        
        self.contentView = UIView()
        self.contentView.backgroundColor = .clear
        self.contentView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        addSubview(self.contentView)

        // Dividers
        
        self.dividerHairlineView = UIHairlineView()
        addSubview(self.dividerHairlineView)
        
        self.dividerGradientView = UIGradientView()
        addSubview(self.dividerGradientView)
        
        // Update
        
        updateAnchor()
        updateBackground()
        updateDivider()
        
    }
        
    public func setSafeAreaHeightOverride(_ height: CGFloat) {
        self.safeAreaViewHeightConstraint.update(offset: height)
    }
    
    public func setBackgroundAlpha(_ alpha: CGFloat) {
        
        self.backgroundColorView.alpha = alpha
        self.backgroundGradientView.alpha = alpha
        self.backgroundBlurView.alpha = alpha
    
    }
    
    public func setBackgroundTransform(_ transform: CGAffineTransform) {
        
        self.backgroundColorView.transform = transform
        self.backgroundGradientView.transform = transform
        self.backgroundBlurView.transform = transform
        
    }
    
    // MARK: Private
    
    private func updateAnchor() {
  
        let insets: UIEdgeInsets = UIApplication.shared
            .firstKeyWindow?
            .safeAreaInsets ?? .zero
        
        switch self.anchor {
        case .top:
            
            self.backgroundGradientView.direction = .down
            
            self.safeAreaView.snp.remakeConstraints { make in
                make.left.top.right.equalToSuperview()
                self.safeAreaViewHeightConstraint = make.height.equalTo(insets.top).constraint
            }
            
            self.contentView.snp.remakeConstraints { make in
                make.top.equalTo(self.safeAreaView.snp.bottom)
                make.left.bottom.right.equalToSuperview()
            }
            
        case .bottom:
            
            self.backgroundGradientView.direction = .up
            
            self.safeAreaView.snp.remakeConstraints { make in
                make.left.bottom.right.equalToSuperview()
                self.safeAreaViewHeightConstraint = make.height.equalTo(insets.bottom).constraint
            }
            
            self.contentView.snp.remakeConstraints { make in
                make.bottom.equalTo(self.safeAreaView.snp.top)
                make.left.top.right.equalToSuperview()
            }
            
        }
                
    }
    
    private func updateBackground() {
        
        setBackgroundAlpha(1)
        
        switch self.background {
        case .color(let color):
            
            self.backgroundColorView.backgroundColor = color
            self.backgroundGradientView.isHidden = true
            self.backgroundBlurView.isHidden = true
            
        case .gradient(let colors):
            
            self.backgroundColorView.isHidden = true
            
            self.backgroundGradientView.colors = colors
            self.backgroundGradientView.isHidden = false
            
            self.backgroundBlurView.isHidden = true
            
        case .blur(let style):
            
            self.backgroundColorView.isHidden = true
            self.backgroundGradientView.isHidden = true
            
            self.backgroundBlurView.effect = UIBlurEffect(style: style)
            self.backgroundBlurView.isHidden = false
            
        }
        
    }
    
    private func updateDivider() {
        
        switch self.divider {
        case .none:
            
            self.dividerHairlineView.isHidden = true
            self.dividerGradientView.isHidden = true
            
        case .hairline:
            
            self.dividerHairlineView.isHidden = false
            self.dividerGradientView.isHidden = true
            
        case .darkGradient:
            
            self.dividerHairlineView.isHidden = true
            self.dividerGradientView.isHidden = false
            
            self.dividerGradientView.colors = [
                UIColor.black.withAlphaComponent(0.05),
                UIColor.clear
            ]
            
        case .lightGradient:
            
            self.dividerGradientView.colors = [
                UIColor.white.withAlphaComponent(0.05),
                UIColor.clear
            ]
            
            self.dividerHairlineView.isHidden = true
            self.dividerGradientView.isHidden = false
            
        }
        
        switch self.dividerAnchor {
        case .top:
            
            self.dividerHairlineView.snp.remakeConstraints { make in
                make.left.top.right.equalToSuperview()
            }
            
            self.dividerGradientView.direction = .up
            self.dividerGradientView.snp.remakeConstraints { make in
                make.bottom.equalTo(self.snp.top)
                make.left.right.equalToSuperview()
                make.height.equalTo(30)
            }
            
        case .bottom:
            
            self.dividerHairlineView.snp.remakeConstraints { make in
                make.left.bottom.right.equalToSuperview()
            }
            
            self.dividerGradientView.direction = .down
            self.dividerGradientView.snp.remakeConstraints { make in
                make.top.equalTo(self.snp.bottom)
                make.left.right.equalToSuperview()
                make.height.equalTo(30)
            }
            
        }
        
    }
    
}
