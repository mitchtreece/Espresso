//
//  ContextMenu+UITableView.swift
//  Espresso
//
//  Created by Mitch Treece on 8/1/22.
//

import UIKit

public extension ContextMenu {
    
    /// A `UITableView` context menu configuration used to forward
    /// handling of relevant delegate calls to the context menu.
    struct TableConfiguration {
        
        private weak var menu: ContextMenu!
        
        internal init(menu: ContextMenu) {
            self.menu = menu
        }
        
        /// Asks the configuration for a context menu configuration.
        ///
        /// If possible, this function also adds the cell for this index-path to the context menu's
        /// data dictionary under the key "cell".
        ///
        ///     let cell = contextMenu.data["cell"] as? UITableViewCell
        public func tableView(_ tableView: UITableView,
                              contextMenuConfigurationForRowAt indexPath: IndexPath,
                              point: CGPoint) -> UIContextMenuConfiguration {
            
            if let cell = tableView.cellForRow(at: indexPath) {
                
                self.menu?.setData(
                    cell,
                    forKey: "cell"
                )
                
            }
            
            return self.menu
                .buildConfiguration()
            
        }
        
        /// Tells the configuration that the context menu is about to be presented.
        public func tableView(_ tableView: UITableView,
                              willDisplayContextMenu configuration: UIContextMenuConfiguration,
                              animator: UIContextMenuInteractionAnimating?) {

            self.menu
                .willPresent?()

        }

        /// Tells the configuration that the context menu is about to be dismissed.
        public func tableView(_ tableView: UITableView,
                              willEndContextMenuInteraction configuration: UIContextMenuConfiguration,
                              animator: UIContextMenuInteractionAnimating?) {

            self.menu
                .willDismiss?()

        }

        /// Asks the configuration for a highlight targeted preview for the context menu.
        public func tableView(_ tableView: UITableView,
                              previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {

            return self.menu
                .targetedHighlightPreviewProvider?(self.menu.data)

        }

        /// Asks the configuration for a dismiss targeted preview for the context menu.
        public func tableView(_ tableView: UITableView,
                              previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {

            self.menu
                .targetedDismissPreviewProvider?(self.menu.data)

        }

        /// Tells the configuration that the context menu's preview is about to be committed.
        public func tableView(_ tableView: UITableView,
                              willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
                              animator: UIContextMenuInteractionCommitAnimating) {

            guard let committer = self.menu.previewCommitter else { return }

            animator.preferredCommitStyle = self.menu.previewCommitStyle

            animator.addCompletion {

                committer(
                    self.menu.data,
                    animator.previewViewController
                )

            }

        }
        
    }
    
}
