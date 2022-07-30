//
//  UIContextMenu.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import UIKit

public typealias UIContextMenuContentPreviewCommitter = (UIViewController?)->()

public class UIContextMenu: NSObject, ContextMenu, ContextMenuBuildable {
    
    public typealias Data = [String: Any]
    public typealias PreviewProvider = (Data)->UIViewController?
    public typealias PreviewCommitter = (Data, UIViewController?)->()
    public typealias TargetedPreviewProvider = (Data)->UITargetedPreview?
    
    /// The context menu's title.
    public var title: String

    /// The context menu's subtitle.
    public var subtitle: String?
    
    /// The context menu's image.
    public var image: UIImage? // Not visible on root menus

    /// The context menu's identifier.
    public var identifier: String?
    
    /// The contet menu's options.
    public var options: UIMenu.Options = []

    /// The context menu's elements.
    public var elements: [ContextMenuElement]
    
    /// The context menu's preview providing closure.
    ///
    /// If this is `nil`, the system will automatically
    /// generate a preview based on the context menu's parent view.
    public var previewProvider: PreviewProvider?
    
    /// The context menu's preview commit closure.
    ///
    /// This will be called after a user taps on the context menu's preview.
    /// If possible, the currently previewed view controller will be provided
    /// to the closure. Perform navigation or other tasks if needed.
    public var previewCommitter: PreviewCommitter?

    /// The context menu's preferred preview commit style; _defaults to pop_.
    public var previewCommitStyle: UIContextMenuInteractionCommitStyle = .pop

    public var targetedHighlightPreviewProvider: TargetedPreviewProvider?
    
    public var targetedDismissPreviewProvider: TargetedPreviewProvider?
    
    /// Flag indicating if system-suggested menu items should be displayed.
    public var includeSuggestedItems: Bool = false
    
    public var willPresent: (()->())?
    public var willDismiss: (()->())?
    
    /// The context menu's associated data dictionary.
    public private(set) var data = Data()

    public init(title: String,
                elements: [ContextMenuElement]) {
        
        self.title = title
        self.elements = elements
        
    }
    
    public init(_ block: (inout ContextMenuRootBuilder)->()) {

        var builder = ContextMenuRootBuilder()
        block(&builder)
                
        self.title = builder.title ?? ""
        self.subtitle = builder.subtitle
        self.identifier = builder.identifier
        self.options = builder.options
        self.elements = builder.elements
        
        self.previewProvider = builder.previewProvider
        self.previewCommitter = builder.previewCommitter
        self.previewCommitStyle = builder.previewCommitStyle
        self.targetedHighlightPreviewProvider = builder.targetedHighlightPreviewProvider
        self.targetedDismissPreviewProvider = builder.targetedDismissPreviewProvider
        
        self.includeSuggestedItems = builder.includeSuggestedItems
        
        self.willPresent = builder.willPresent
        self.willDismiss = builder.willDismiss
        
    }
    
    // MARK: Data
    
    @discardableResult
    public func addData(_ data: Any,
                        forKey key: String) -> Self {
        
        self.data[key] = data
        return self
        
    }
    
    // MARK: Builders
    
    public func build() -> UIMenuElement {
                
        return UIMenu(
            title: self.title,
            image: self.image,
            identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
            options: self.options,
            children: self.elements.map { $0.build() }
        )
        
    }
    
    public func buildMenu(suggestedItems: [UIMenuElement] = []) -> UIMenu {
                
        guard !suggestedItems.isEmpty && self.includeSuggestedItems else {
            return build() as! UIMenu
        }
        
        var childElements = self.elements
            .map { $0.build() }

        if self.includeSuggestedItems {
            childElements.append(contentsOf: suggestedItems)
        }

        return UIMenu(
            title: self.title,
            image: self.image,
            identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
            options: self.options,
            children: childElements
        )
        
    }
    
    public func buildConfiguration() -> UIContextMenuConfiguration {
        
        var previewProvider: UIContextMenuContentPreviewProvider?
        var actionProvider: UIContextMenuActionProvider?
        
        if let preview = self.previewProvider {
            
            previewProvider = {
                return preview(self.data)
            }
            
        }
        
        if !self.elements.isEmpty {
            
            // If our menu has no elements, we should provide
            // no menu-building action provider. This will make
            // the system only display our preview if possible.
            
            actionProvider = { items in
                self.buildMenu(suggestedItems: items)
            }
            
        }
      
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: previewProvider,
            actionProvider: actionProvider
        )
        
    }
    
}

extension UIContextMenu: UIContextMenuInteractionDelegate {
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        return buildConfiguration()
        
    }
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       willDisplayMenuFor configuration: UIContextMenuConfiguration,
                                       animator: UIContextMenuInteractionAnimating?) {
        
        self.willPresent?()
        
    }
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       willEndFor configuration: UIContextMenuConfiguration,
                                       animator: UIContextMenuInteractionAnimating?) {
        
        self.willDismiss?()
        
    }
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       previewForHighlightingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        
        return self.targetedHighlightPreviewProvider?(self.data)
        
    }
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       previewForDismissingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        
        return self.targetedDismissPreviewProvider?(self.data)
        
    }
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
                                       animator: UIContextMenuInteractionCommitAnimating) {

        // If this protocol function is implemented,
        // the system always performs some kind of animation.
        // This isn't ideal, but doesn't hurt anything.
        //
        // Need to find a way to conditionally adopt this function
        // Only when needed.
        //
        // responds(toSelector:) fuckery?
        
        guard let committer = self.previewCommitter else { return }
        
        animator.preferredCommitStyle = self.previewCommitStyle

        animator.addCompletion {
                        
            committer(
                self.data,
                animator.previewViewController
            )
            
        }
        
    }
    
}
