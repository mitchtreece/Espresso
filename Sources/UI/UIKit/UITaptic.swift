//
//  UITaptic.swift
//  Espresso
//
//  Created by Mitch Treece on 7/5/18.
//

import UIKit

/// Wrapper class over `UIFeedbackGenerator`.
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
    ///
    /// - parameter style: The taptic style.
    public init(style: Style) {
        
        switch style {
        case .selection: self.generator = UISelectionFeedbackGenerator()
        case .impact(let _style): self.generator = UIImpactFeedbackGenerator(style: _style)
        case .notification: self.generator = UINotificationFeedbackGenerator()
        }
        
        self.style = style
        
        prepare()

    }
    
    /// Tells the taptic that it's about to begin.
    public func prepare() {
        self.generator.prepare()
    }
    
    /// Plays the taptic.
    public func play() {
        
        switch style {
        case .selection: (generator as! UISelectionFeedbackGenerator).selectionChanged()
        case .impact: (generator as! UIImpactFeedbackGenerator).impactOccurred()
        case .notification(let _type): (generator as! UINotificationFeedbackGenerator).notificationOccurred(_type)
        }
        
    }
    
}
