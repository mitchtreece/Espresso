//
//  UITaptic.swift
//  Espresso
//
//  Created by Mitch Treece on 7/5/18.
//

import UIKit

/// Taptic wrapper class over `UIFeedbackGenerator`.
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

    /// Initializes a taptic with a specified style.
    /// - Parameter style: The taptic style.
    public init(_ style: Style) {
        
        switch style {
        case .selection: self.generator = UISelectionFeedbackGenerator()
        case .impact(let _style): self.generator = UIImpactFeedbackGenerator(style: _style)
        case .notification: self.generator = UINotificationFeedbackGenerator()
        }
        
        self.generator.prepare()
        self.style = style
        
    }

    /// Prepares the taptic feedback.
    public func prepare() {
        self.generator.prepare()
    }
    
    /// Plays the taptic feedback.
    public func play() {
        
        switch style {
        case .selection: (self.generator as! UISelectionFeedbackGenerator).selectionChanged()
        case .impact: (self.generator as! UIImpactFeedbackGenerator).impactOccurred()
        case .notification(let type): (self.generator as! UINotificationFeedbackGenerator).notificationOccurred(type)
        }
        
    }
    
}
