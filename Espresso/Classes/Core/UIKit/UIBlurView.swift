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
    
    private var blurView: UIVisualEffectView!
    private var blurStyle: UIBlurEffect.Style = .light
    
    /// The blur view's content view.
    ///
    /// Add subviews to this, and not `UIBlurView` directly.
    public var contentView: UIView {
        return blurView.contentView
    }
    
    open override func tintColorDidChange() {
        self.backgroundColor = self.tintColor
    }
    
    /// Initializes a new `UIBlurView` with a specified blur style.
    /// - Parameter frame: The view's frame.
    /// - Parameter style: The blur style.
    public init(frame: CGRect, style: UIBlurEffect.Style) {
        
        super.init(frame: frame)
        self.blurStyle = style
        setup()
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        self.clipsToBounds = true
        
        self.blurView = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        self.addSubview(self.blurView)
        self.blurView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
}
