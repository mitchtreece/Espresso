//
//  UIContextMenu.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import UIKit

public class UIContextMenu: NSObject {
    
    /// The context menu's title.
    public var title: String

    /// The context menu's image.
    public var image: UIImage?

    /// The context menu's identifier.
    public var identifier: String?
    
    /// The contet menu's options.
    public var options: UIMenu.Options

    /// The context menu's items.
    public var items: [Item]
    
    /// The context menu's preview providing closure.
    ///
    /// If this is `nil`, the system will automatically
    /// generate a preview based on the context menu's parent view.
    public var preview: UIContextMenuContentPreviewProvider?
    
    /// The context menu's preview commit closure.
    ///
    /// This will be called after a user taps on the context menu's preview.
    /// If possible, the currently previewed view controller will be provided
    /// to the closure. Perform navigation or other tasks if needed.
    public var previewCommit: ((UIViewController?)->())?

    /// The context menu's preferred preview commit style; _defaults to pop_.
    public var previewCommitStyle: UIContextMenuInteractionCommitStyle = .pop

    /// Flag indicating if system-suggested menu items should be displayed.
    public var includeSuggestedItems: Bool = false

    /// Initializes a new `UIContextMenu`.
    ///
    /// - parameter title: The context menu's title.
    /// - parameter image: The context menu's image; _defaults to nil_.
    /// - parameter identifier: The context menu's identifier; _defaults to nil_.
    /// - parameter options: The context menu's options; _defaults to none_.
    /// - parameter items: The context menu's items.
    /// - parameter preview: The context menu's preview providing closure; _defaults to nil_.
    public init(title: String,
                image: UIImage? = nil,
                identifier: String? = nil,
                options: UIMenu.Options = [],
                items: [Item],
                preview: UIContextMenuContentPreviewProvider? = nil) {

        self.title = title
        self.image = image
        self.identifier = identifier
        self.options = options
        self.items = items
        self.preview = preview

    }
    
    internal func buildMenu(suggestedItems: [UIMenuElement] = []) -> UIMenu {
        
        var children = self.items
            .map { $0.menuItem() }
            .map { $0.menuElement() }

        if self.includeSuggestedItems {
            children.append(contentsOf: suggestedItems)
        }

        return UIMenu(
            title: self.title,
            image: self.image,
            identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
            options: self.options,
            children: children
        )
        
    }
    
    internal func buildConfiguration() -> UIContextMenuConfiguration {
        
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: self.preview,
            actionProvider: { self.buildMenu(suggestedItems: $0) }
        )
        
    }
    
}

extension UIContextMenu: UIContextMenuInteractionDelegate {
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        return buildConfiguration()
        
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

        guard let commit = self.previewCommit else {
            return
        }

        animator.preferredCommitStyle = self.previewCommitStyle

        animator.addCompletion {
            commit(animator.previewViewController)
        }
        
    }
    
}
