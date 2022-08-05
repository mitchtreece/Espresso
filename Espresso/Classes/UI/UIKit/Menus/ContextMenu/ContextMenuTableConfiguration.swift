//
//  ContextMenuTableConfiguration.swift
//  Espresso
//
//  Created by Mitch Treece on 8/1/22.
//

import UIKit

/// A `UITableView` context menu configuration used to forward
/// handling of relevant delegate calls to the context menu.
public struct ContextMenuTableConfiguration {
    
    private weak var contextMenu: ContextMenu!
    
    internal init(contextMenu: ContextMenu) {
        self.contextMenu = contextMenu
    }
    
    /// Asks the configuration for a context menu configuration.
    ///
    /// This also adds the associated `indexPath` & `cell` to
    /// the context menu's data dictionary.
    ///
    /// ```
    /// let indexPath = contextMenu.data["indexPath"] as? IndexPath
    /// let cell = contextMenu.data["cell"] as? UITableViewCell
    /// ```
    public func tableView(_ tableView: UITableView,
                          contextMenuConfigurationForRowAt indexPath: IndexPath,
                          point: CGPoint) -> UIContextMenuConfiguration {
                
        self.contextMenu.setData(
            indexPath,
            forKey: "indexPath"
        )
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
            self.contextMenu.setData(
                cell,
                forKey: "cell"
            )
            
        }
        
        return self.contextMenu
            .configuration()
        
    }
    
    /// Tells the configuration that the context menu is about to be presented.
    public func tableView(_ tableView: UITableView,
                          willDisplayContextMenu configuration: UIContextMenuConfiguration,
                          animator: UIContextMenuInteractionAnimating?) {

        self.contextMenu
            .willPresent?()

    }

    /// Tells the configuration that the context menu is about to be dismissed.
    public func tableView(_ tableView: UITableView,
                          willEndContextMenuInteraction configuration: UIContextMenuConfiguration,
                          animator: UIContextMenuInteractionAnimating?) {

        self.contextMenu
            .willDismiss?()

    }

    /// Asks the configuration for a highlight targeted preview for the context menu.
    public func tableView(_ tableView: UITableView,
                          previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {

        return self.contextMenu
            .targetedHighlightPreviewProvider?(self.contextMenu.data)

    }

    /// Asks the configuration for a dismiss targeted preview for the context menu.
    public func tableView(_ tableView: UITableView,
                          previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {

        self.contextMenu
            .targetedDismissPreviewProvider?(self.contextMenu.data)

    }

    /// Tells the configuration that the context menu's preview is about to be committed.
    public func tableView(_ tableView: UITableView,
                          willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
                          animator: UIContextMenuInteractionCommitAnimating) {

        guard let committer = self.contextMenu.previewCommitter else { return }

        animator.preferredCommitStyle = self.contextMenu.previewCommitStyle

        animator.addCompletion {

            committer(
                self.contextMenu.data,
                animator.previewViewController
            )

        }

    }
    
}
