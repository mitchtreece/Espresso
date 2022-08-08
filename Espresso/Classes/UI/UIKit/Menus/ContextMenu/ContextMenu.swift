//
//  ContextMenu.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import UIKit

/// Provides a previewing `UIViewController` used while a context menu's preview is being committed.
public typealias UIContextMenuContentPreviewCommitter = (UIViewController?)->()

public class ContextMenu: NSObject {

    /// Provides a buildable context menu used to configure an actual context menu.
    public typealias Provider = (inout ContextMenuBuildable)->()
        
    /// Provides context menu data, and returns a view controller for previewing.
    public typealias PreviewProvider = ([String: Any])->UIViewController?
    
    /// Provides context menu data and a previewing view controller used while a context menu's preview is being committed.
    public typealias PreviewCommitter = ([String: Any], UIViewController?)->()
    
    /// Provides context menu data, and returns a targeted preview for the context menu.
    public typealias TargetedPreviewProvider = ([String: Any])->UITargetedPreview?
    
    public private(set) var title: String?
    public private(set) var identifier: MenuElementIdentifier?
    public private(set) var configurationIdentifier: NSCopying?
    public private(set) var options: UIMenu.Options = []
    public private(set) var children: [UIMenuElement] = []
    public private(set) var previewProvider: PreviewProvider?
    public private(set) var previewCommitter: PreviewCommitter?
    public private(set) var previewCommitStyle: UIContextMenuInteractionCommitStyle = .pop
    public private(set) var targetedHighlightPreviewProvider: TargetedPreviewProvider?
    public private(set) var targetedDismissPreviewProvider: TargetedPreviewProvider?
    public private(set) var includeSuggestedElements: Bool = false
    public private(set) var willPresent: (()->())?
    public private(set) var willDismiss: (()->())?

    @available(iOS 16, *)
    public private(set) var elementSize: UIMenu.ElementSize {
        get {
            return (self._elementSize as? UIMenu.ElementSize) ?? .large
        }
        set {
            self._elementSize = newValue
        }
    }

    private var _elementSize: Any?
            
    /// The context menu's associated data dictionary.
    public private(set) var data = [String: Any]()

    /// The context menu's table view configuration.
    ///
    /// Use this to forward handling of relevant table view delegate calls to the context menu.
    public private(set) lazy var tableConfiguration: ContextMenuTableConfiguration = {
        return ContextMenuTableConfiguration(contextMenu: self)
    }()

    /// The context menu's collection view configuration.
    ///
    /// Use this to forward handling of relevant collection view delegate calls to the context menu.
    public private(set) lazy var collectionConfiguration: ContextMenuCollectionConfiguration = {
        return ContextMenuCollectionConfiguration(contextMenu: self)
    }()
        
    internal weak var interaction: UIContextMenuInteraction?
    
    // MARK: Initializers
    
    public convenience init(builder: Provider) {

        var buildable: ContextMenuBuildable = ContextMenuBuilder()
        
        builder(&buildable)
                
        self.init(buildable: buildable)
        
    }
    
    private init(buildable: ContextMenuBuildable) {
        
        self.title = buildable.title
        self.identifier = buildable.identifier
        self.configurationIdentifier = buildable.configurationIdentifier
        self.options = buildable.options
        self.children = buildable.children
        self.previewProvider = buildable.previewProvider
        self.previewCommitter = buildable.previewCommitter
        self.previewCommitStyle = buildable.previewCommitStyle
        self.targetedHighlightPreviewProvider = buildable.targetedHighlightPreviewProvider
        self.targetedDismissPreviewProvider = buildable.targetedDismissPreviewProvider
        self.includeSuggestedElements = buildable.includeSuggestedElements
        self.willPresent = buildable.willPresent
        self.willDismiss = buildable.willDismiss
                
        super.init()
        
        if #available(iOS 16, *) {
            self.elementSize = buildable.elementSize
        }
        
    }
    
    // MARK: Add & Remove
    
    @discardableResult
    public func add(to target: ContextMenuTarget) -> Self {
        
        target.addContextMenu(self)
        return self
        
    }
    
    public func removeFromTarget() {
        
        self.interaction?
            .view?
            .removeContextMenu(self)
        
    }
    
    // MARK: Data
    
    @discardableResult
    public func setData(_ data: Any,
                        forKey key: String) -> Self {
        
        self.data[key] = data
        return self
        
    }
    
    public func getDataForKey(_ key: String) -> Any? {
        return self.data[key]
    }
    
    // MARK: UIContextMenuConfiguration

    /// Builds a `UIContextMenuConfiguration` for this context menu.
    ///
    /// - returns: A new `UIContextMenuConfiguration`.
    public func configuration() -> UIContextMenuConfiguration {
        
        var previewProvider: UIContextMenuContentPreviewProvider?
        var actionProvider: UIContextMenuActionProvider?

        if let preview = self.previewProvider {

            previewProvider = {
                return preview(self.data)
            }

        }

        if !self.children.isEmpty {

            // Only assign an action provider if we have elements.
            // If we don't have elements, we only want to show
            // a preview (if provided).

            actionProvider = { suggestedElements in

                var additionalElements = [UIMenuElement]()

                if self.includeSuggestedElements {
                    additionalElements.append(contentsOf: suggestedElements)
                }

                return self.menu(additionalElements: additionalElements)

            }

        }
        
        return UIContextMenuConfiguration(
            identifier: self.configurationIdentifier,
            previewProvider: previewProvider,
            actionProvider: actionProvider
        )

    }
    
    // MARK: UIContextMenuInteraction
    
    @available(iOS 14, *)
    public func updateVisibleMenu(block: (UIMenu)->(UIMenu)) {
        
        self.interaction?
            .updateVisibleMenu(block)
        
    }
    
    public func dismiss() {
        
        self.interaction?
            .dismissMenu()
        
    }
    
    // MARK: Private
    
    private func update(using buildable: ContextMenuBuildable) {
        
        self.title = buildable.title
        self.identifier = buildable.identifier
        self.configurationIdentifier = buildable.configurationIdentifier
        self.options = buildable.options
        self.children = buildable.children
        self.previewProvider = buildable.previewProvider
        self.previewCommitter = buildable.previewCommitter
        self.previewCommitStyle = buildable.previewCommitStyle
        self.targetedHighlightPreviewProvider = buildable.targetedHighlightPreviewProvider
        self.targetedDismissPreviewProvider = buildable.targetedDismissPreviewProvider
        self.includeSuggestedElements = buildable.includeSuggestedElements
        self.willPresent = buildable.willPresent
        self.willDismiss = buildable.willDismiss
                
        if #available(iOS 16, *) {
            self.elementSize = buildable.elementSize
        }
        
    }

    private func menu(additionalElements: [UIMenuElement]) -> UIMenu {
        
        let menu = UIMenu(
            title: self.title ?? "",
            identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
            options: self.options,
            children: self.children.appending(contentsOf: additionalElements)
        )

        if #available(iOS 16, *) {
            menu.preferredElementSize = self.elementSize
        }
                
        return menu

    }
    
}

// MARK: UIContextMenuInteractionDelegate

extension ContextMenu: UIContextMenuInteractionDelegate {

    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {

        return configuration()

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
