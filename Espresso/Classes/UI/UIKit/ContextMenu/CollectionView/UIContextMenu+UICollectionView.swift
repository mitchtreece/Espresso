//
//  UIContextMenu+UICollectionView.swift
//  Espresso
//
//  Created by Mitch Treece on 8/1/22.
//

import UIKit

public extension UIContextMenu {
    
    /// A `UICollectionView` context menu configuration used to forward
    /// handling of relevant delegate calls to the context menu.
    struct CollectionConfiguration {
        
        private weak var contextMenu: UIContextMenu!
        
        internal init(contextMenu: UIContextMenu) {
            self.contextMenu = contextMenu
        }
        
        /// Asks the configuration for a context menu configuration.
        ///
        /// If possible, this function also adds the cell for this index-path to the context menu's
        /// data dictionary under the key "cell".
        ///
        ///     let cell = contextMenu.data["cell"] as? UICollectionViewCell
        public func collectionView(_ collectionView: UICollectionView,
                                   contextMenuConfigurationForItemAt indexPath: IndexPath,
                                   point: CGPoint) -> UIContextMenuConfiguration {
            
            if let cell = collectionView.cellForItem(at: indexPath) {
                
                self.contextMenu.setData(
                    cell,
                    forKey: "cell"
                )
                
            }
            
            return self.contextMenu
                .buildConfiguration()
            
        }
        
        /// Tells the configuration that the context menu is about to be presented.
        public func collectionView(_ collectionView: UICollectionView,
                                   willDisplayContextMenu configuration: UIContextMenuConfiguration,
                                   animator: UIContextMenuInteractionAnimating?) {
            
            self.contextMenu
                .willPresent?()
            
        }
        
        /// Tells the configuration that the context menu is about to be dismissed.
        public func collectionView(_ collectionView: UICollectionView,
                                   willEndContextMenuInteraction configuration: UIContextMenuConfiguration,
                                   animator: UIContextMenuInteractionAnimating?) {
            
            self.contextMenu
                .willDismiss?()
            
        }

        /// Asks the configuration for a highlight targeted preview for the context menu.
        public func collectionView(_ collectionView: UICollectionView,
                                   previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
            
            return self.contextMenu
                .targetedHighlightPreviewProvider?(self.contextMenu.data)
            
        }
        
        /// Asks the configuration for a dismiss targeted preview for the context menu.
        public func collectionView(_ collectionView: UICollectionView,
                                   previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
            
            return self.contextMenu
                .targetedDismissPreviewProvider?(self.contextMenu.data)
            
        }

        /// Tells the configuration that the context menu's preview is about to be committed.
        public func collectionView(_ collectionView: UICollectionView,
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
    
}
