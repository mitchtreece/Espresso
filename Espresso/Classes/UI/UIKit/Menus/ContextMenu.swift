//
//  ContextMenu.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import UIKit

/// Provides a previewing `UIViewController` used while a context menu preview is being committed.
public typealias UIContextMenuContentPreviewCommitter = (UIViewController?)->()

public class ContextMenu: NSObject, ContextMenuElement {
    
    public typealias MenuElementType = UIMenu
    
    /// Provides context menu data, and returns a view controller for previewing.
    public typealias PreviewProvider = ([String: Any])->UIViewController?
    
    /// Provides context menu data and a previewing view controller used while a context menu preview is being committed.
    public typealias PreviewCommitter = ([String: Any], UIViewController?)->()
    
    /// Provides context menu data, and returns a targeted preview for the context menu.
    public typealias TargetedPreviewProvider = ([String: Any])->UITargetedPreview?
    
    public var title: String?
    public var identifier: String?
    public var options: UIMenu.Options = []
    public var elementSize: Menu.ElementSize = .large
    public var elements: [any MenuElement] = []

    public var previewProvider: PreviewProvider?
    public var previewCommitter: PreviewCommitter?
    public var previewCommitStyle: UIContextMenuInteractionCommitStyle = .pop
    public var targetedHighlightPreviewProvider: TargetedPreviewProvider?
    public var targetedDismissPreviewProvider: TargetedPreviewProvider?
    public var includeSuggestedElements: Bool = false
    public var willPresent: (()->())?
    public var willDismiss: (()->())?
    
    /// The context menu's associated data dictionary.
    public private(set) var data = [String: Any]()

    /// The context menu's table view configuration.
    ///
    /// Use this to forward handling of relevant table view delegate calls to the context menu.
    public private(set) lazy var tableConfiguration: TableConfiguration = {
        return TableConfiguration(menu: self)
    }()

    /// The context menu's collection view configuration.
    ///
    /// Use this to forward handling of relevant collection view delegate calls to the context menu.
    public private(set) lazy var collectionConfiguration: CollectionConfiguration = {
        return CollectionConfiguration(menu: self)
    }()

    public init(title: String? = nil,
                identifier: String? = nil,
                options: UIMenu.Options = [],
                elementSize: Menu.ElementSize = .large,
                elements: [any MenuElement] = [],
                previewProvider: PreviewProvider?,
                previewCommitter: PreviewCommitter?,
                previewCommitStyle: UIContextMenuInteractionCommitStyle = .pop,
                targetedHighlightPreviewProvider: TargetedPreviewProvider? = nil,
                targetedDismissPreviewProvider: TargetedPreviewProvider? = nil,
                includeSuggestedElements: Bool = false,
                willPresent: (()->())? = nil,
                willDismiss: (()->())? = nil) {

        self.title = title
        self.identifier = identifier
        self.options = options
        self.elementSize = elementSize
        self.elements = elements
        
        self.previewProvider = previewProvider
        self.previewCommitter = previewCommitter
        self.previewCommitStyle = previewCommitStyle
        self.targetedHighlightPreviewProvider = targetedHighlightPreviewProvider
        self.targetedDismissPreviewProvider = targetedDismissPreviewProvider
        self.includeSuggestedElements = includeSuggestedElements
        self.willPresent = willPresent
        self.willDismiss = willDismiss
        
    }
    
    internal convenience init(builder: ContextMenuBuilder) {
        
        self.init(
            title: builder.title,
            identifier: builder.identifier,
            options: builder.options,
            elementSize: builder.elementSize,
            elements: builder.elements,
            previewProvider: builder.previewProvider,
            previewCommitter: builder.previewCommitter,
            previewCommitStyle: builder.previewCommitStyle,
            targetedHighlightPreviewProvider: builder.targetedHighlightPreviewProvider,
            targetedDismissPreviewProvider: builder.targetedDismissPreviewProvider,
            includeSuggestedElements: builder.includeSuggestedElements,
            willPresent: builder.willPresent,
            willDismiss: builder.willDismiss
        )
        
    }
    
    public convenience init(_ block: (inout ContextMenuBuilder)->()) {
        
        var builder = ContextMenuBuilder()
        block(&builder)
        
        self.init(builder: builder)
        
    }
    
    /// Adds the context menu to a target.
    ///
    /// - parameter target: The target to add the context menu to.
    /// - returns: This context menu.
    ///
    /// This function acts differently depending on the type of the target.
    ///
    /// For a `UIView`, this calls `addInteraction(interaction:)`
    /// and does **not** hold a strong reference to the context menu.
    ///
    /// For a `UIButton` on iOS 14 or higher, this sets the button's `menu` property.
    /// On iOS 13 and lower, this treats the button like a `UIView` and does **not**
    /// hold a strong reference to the context menu.
    ///
    /// For a `UIBarButtonItem` on iOS 14 or higher, this sets the item's `menu` property.
    /// On iOS 13 or lower, this is ignored.
    @discardableResult
    public func addTo(_ target: ContextMenuTarget) -> Self {

        target.addContextMenu(self)
        return self

    }
    
    @discardableResult
    public func setData(_ data: Any,
                        forKey key: String) -> Self {
        
        self.data[key] = data
        return self
        
    }
    
    public func getDataForKey(_ key: String) -> Any? {
        return self.data[key]
    }
    
    public func build() -> UIMenu {

        let menu = UIMenu(
            title: self.title ?? "",
            identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
            options: self.options,
            children: self.elements.map { $0.build() }
        )
        
        if #available(iOS 16, *) {
            menu.preferredElementSize = self.elementSize.asMenuElementSize()
        }

        return menu
        
    }

    /// Builds a `UIMenu` from this context menu.
    ///
    /// - parameter additionalElements: Additional elements to append to this context menu's
    /// existing elements while building; _defaults to none_.
    /// - returns: A new `UIMenu`.
    public func build(additionalElements: [UIMenuElement]) -> UIMenu {

        guard !additionalElements.isEmpty else {
            return build()
        }

        let childElements = self.elements
            .map { $0.build() }
            .appending(contentsOf: additionalElements)

        let menu = UIMenu(
            title: self.title ?? "",
            identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
            options: self.options,
            children: childElements
        )

        if #available(iOS 16, *) {
            menu.preferredElementSize = self.elementSize.asMenuElementSize()
        }

        return menu

    }

    /// Builds a context menu configuration.
    public func buildConfiguration() -> UIContextMenuConfiguration {

        var previewProvider: UIContextMenuContentPreviewProvider?
        var actionProvider: UIContextMenuActionProvider?

        if let preview = self.previewProvider {

            previewProvider = {
                return preview(self.data)
            }

        }

        if !self.elements.isEmpty {

            // Only assign an action provider if we have elements.
            // If we don't have elements, we only want to show
            // a preview (if provided).

            actionProvider = { suggestedElements in

                var additionalElements = [UIMenuElement]()

                if self.includeSuggestedElements {
                    additionalElements.append(contentsOf: suggestedElements)
                }

                return self.build(additionalElements: additionalElements)

            }

        }

        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: previewProvider,
            actionProvider: actionProvider
        )

    }
    
}

// MARK: UIContextMenuInteractionDelegate

extension ContextMenu: UIContextMenuInteractionDelegate {

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
