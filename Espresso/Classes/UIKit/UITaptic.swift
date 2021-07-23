//
//  UITaptic.swift
//  Espresso
//
//  Created by Mitch Treece on 7/5/18.
//

import UIKit

/// `UITaptic` is a wrapper class over `UIFeedbackGenerator`.
@available(iOS 10, *)
public class UITaptic {
    
    /// Representation of the various taptic styles.
    public enum Style {
        
        /// A selection feedback style
        case selection
        
        /// An impact feedback style
        case impact(UIImpactFeedbackGenerator.FeedbackStyle)
        
        /// A notification feedback style
        case notification(UINotificationFeedbackGenerator.FeedbackType)
        
    }
    
    private var style: Style
    private var generator: UIFeedbackGenerator
    
    /// Initializes a `UITaptic` with a specified style.
    /// - Parameter style: The taptic style.
    public init(style: Style) {
        
        switch style {
        case .selection: self.generator = UISelectionFeedbackGenerator()
        case .impact(let _style): self.generator = UIImpactFeedbackGenerator(style: _style)
        case .notification: self.generator = UINotificationFeedbackGenerator()
        }
        
        self.generator.prepare()
        self.style = style
        
    }
    
    /// Tells the taptic that it's about to be triggered.
    public func prepare() {
        self.generator.prepare()
    }
    
    /// Triggers the taptic's feedback.
    public func trigger() {
        
        switch style {
        case .selection: (generator as! UISelectionFeedbackGenerator).selectionChanged()
        case .impact: (generator as! UIImpactFeedbackGenerator).impactOccurred()
        case .notification(let _type): (generator as! UINotificationFeedbackGenerator).notificationOccurred(_type)
        }
        
    }
    
}
