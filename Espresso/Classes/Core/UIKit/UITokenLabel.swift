//
//  UITokenLabel.swift
//  Espresso
//
//  Created by Mitch Treece on 7/12/18.
//

import Foundation

/**
 `UIView` subclass that emulates a `UILabel` within a styled view.
 */
open class UITokenLabel: UIBaseView {
    
    /**
     Flag indicating whether the token should be filled or not; _defaults to false_.
     */
    public var isFilled: Bool = false
    
    /**
     The token label's fill color. Also used as the border color; _defaults to black_.
     */
    public var fillColor: UIColor = UIColor.black {
        didSet {
            layoutSubviews()
        }
    }
    
    /**
     The token label's border width; _defaults to 1_.
     */
    public var borderWidth: CGFloat = 1
    
    /**
     The token label's corner radius. If no value is specified, _(height / 2)_ will be used.
     */
    public var cornerRadius: CGFloat?
    
    /**
     The token label's background blur style. This overrides the `isFilled` property if set.
     */
    public var blurStyle: UIBlurEffect.Style? {
        didSet {
            layoutSubviews()
        }
    }
    
    /**
     The token label's font; _defaults to system(12)_.
     */
    public var font: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            label.font = font
        }
    }
    
    /**
     The token label's text color; _defaults to black_.
     */
    public var textColor: UIColor = UIColor.black {
        didSet {
            label.textColor = textColor
        }
    }
    
    /**
     The token label's text.
     */
    public var text: String? {
        didSet {
            label.text = text
        }
    }
    
    /**
     The token label's text insets; _defaults to (top: 3, left: 6, bottom: 3, right: 6)_.
     */
    public var textInsets: UIEdgeInsets = UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6) {
        didSet {
            updateTextInsets()
        }
    }
    
    private var blurView: UIVisualEffectView!
    private var fillView: UIView!
    private var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        self.backgroundColor = UIColor.clear
        
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.layer.masksToBounds = true
        blurView.isHidden = true
        addSubview(blurView)
        blurView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        fillView = UIView()
        fillView.backgroundColor = fillColor
        fillView.layer.masksToBounds = true
        addSubview(fillView)
        fillView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        label = UILabel()
        label.backgroundColor = UIColor.clear
        label.textColor = textColor
        label.font = font
        label.textAlignment = .center
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(textInsets.top)
            make.bottom.equalTo(-textInsets.bottom)
            make.left.equalTo(textInsets.left)
            make.right.equalTo(-textInsets.right)
        }
        
    }
    
    private func updateTextInsets() {
        
        label.snp.updateConstraints { (make) in
            make.top.equalTo(textInsets.top)
            make.bottom.equalTo(-textInsets.bottom)
            make.left.equalTo(textInsets.left)
            make.right.equalTo(-textInsets.right)
        }
        
    }
    
    open override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if let style = blurStyle {
            blurView?.effect = UIBlurEffect(style: style)
        }
        
        fillView?.layer.cornerRadius = cornerRadius ?? (self.bounds.height / 2)
        blurView?.layer.cornerRadius = cornerRadius ?? (self.bounds.height / 2)
        
        fillView?.backgroundColor = isFilled ? fillColor : UIColor.clear
        fillView?.layer.borderColor = fillColor.cgColor
        fillView?.layer.borderWidth = isFilled ? 0 : borderWidth
        
        let isBlurred = (blurStyle != nil)
        blurView?.isHidden = !isBlurred
        fillView?.isHidden = isBlurred
        
    }
    
}
