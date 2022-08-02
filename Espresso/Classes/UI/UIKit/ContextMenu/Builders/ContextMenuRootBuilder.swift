//
//  ContextMenuRootBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 7/30/22.
//

import UIKit

/// A root context menu builder.
public struct ContextMenuRootBuilder: ContextMenuElementContainer {
            
    /// The context menu's title.
    public var title: String?
        
    /// The context menu's identifier.
    public var identifier: String?
    
    /// The context menu's options.
    public var options: UIMenu.Options = []
    
    /// The context menu's element size.
    ///
    /// This is supported on iOS 16 and higher. This will be completely
    /// ignored if running on a device on iOS 15 or lower.
    public var elementSize: UIMenuElementSize = .large
    
    /// The context menu's elements.
    public var elements: [ContextMenuElement] = []
    
    /// The context menu's preview provider.
    public var previewProvider: UIContextMenu.PreviewProvider?
    
    /// The context menu's preview committer.
    public var previewCommitter: UIContextMenu.PreviewCommitter?
    
    /// The context menu's preview commit style.
    public var previewCommitStyle: UIContextMenuInteractionCommitStyle = .pop
    
    /// The context menu's targeted highlight preview provider.
    public var targetedHighlightPreviewProvider: UIContextMenu.TargetedPreviewProvider?
    
    /// The context menu's targeted dismiss preview provider.
    public var targetedDismissPreviewProvider: UIContextMenu.TargetedPreviewProvider?
    
    /// Flag indicating if suggested system elements should be displayed.
    public var includeSuggestedElements: Bool = false
    
    /// Closure called when the context menu is about to be presented.
    ///
    /// Depending on what kind of target the context menu is added to,
    /// this closure _may_ or _may not_ be called. Under certain circumstances,
    /// `UIKit` "hijacks" the underlying interaction delegate, causing
    /// presentation & dismissal delegate functions to not be called.
    ///
    /// When added to a `UIView`, this closure is called as expected.
    ///
    /// When added to a `UIButton`, this closure will **not** be called.
    ///
    /// When added to a `UIBarButtonItem` this closure will **not** be called.
    public var willPresent: (()->())?

    /// Closure called when the context menu is about to be dismissed.
    ///
    /// Depending on what kind of target the context menu is added to,
    /// this closure _may_ or _may not_ be called. Under certain circumstances,
    /// `UIKit` "hijacks" the underlying interaction delegate, causing
    /// presentation & dismissal delegate functions to not be called.
    ///
    /// When added to a `UIView`, this closure is called as expected.
    ///
    /// When added to a `UIButton`, this closure will **not** be called.
    ///
    /// When added to a `UIBarButtonItem` this closure will **not** be called.
    public var willDismiss: (()->())?
    
    internal init() {
        //
    }
    
    internal func buildContextMenu() -> UIContextMenu {
        
        return UIContextMenu { menu in
            
            menu.title = self.title
            menu.identifier = self.identifier
            menu.options = self.options
            menu.elementSize = self.elementSize
            menu.elements = self.elements
            
            menu.previewProvider = self.previewProvider
            menu.previewCommitter = self.previewCommitter
            menu.previewCommitStyle = self.previewCommitStyle
            menu.targetedHighlightPreviewProvider = self.targetedHighlightPreviewProvider
            menu.targetedDismissPreviewProvider = self.targetedDismissPreviewProvider
            
            menu.includeSuggestedElements = self.includeSuggestedElements
            
            menu.willPresent = self.willPresent
            menu.willDismiss = self.willDismiss
            
        }
        
    }
    
}
