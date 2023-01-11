//
//  UIBlurView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/2/18.
//

import UIKit
import SnapKit

/// Blurred `UIView` subclass that responds to tint color changes.
open class UIBlurView: UIBaseView {
    
    private var blurView: UIVisualEffectView?
    
    public var blurStyle: UIBlurEffect.Style = .light {
        didSet {
            setupBlurView()
        }
    }
    
    /// The blur view's content view.
    ///
    /// Add subviews to this, and not `UIBlurView` directly.
    public var contentView: UIView {
        return self.blurView!.contentView
    }
    
    open override func tintColorDidChange() {
        self.backgroundColor = self.tintColor
    }
    
    /// Initializes a new `UIBlurView` with a specified blur style.
    /// - Parameter style: The blur style; _defaults to light_.
    public init(style: UIBlurEffect.Style = .light) {
        
        self.blurStyle = style
        super.init(frame: .zero)
        
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    open override func willSetup() {
        
        super.willSetup()
        
        self.clipsToBounds = true
        
        setupBlurView()
        
    }
    
    private func setupBlurView() {
        
        self.blurView?.removeFromSuperview()
        
        self.blurView = UIVisualEffectView(effect: UIBlurEffect(style: self.blurStyle))
        self.addSubview(self.blurView!)
        self.blurView!.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
}
