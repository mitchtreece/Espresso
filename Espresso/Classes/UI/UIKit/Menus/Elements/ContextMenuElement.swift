//
//  ContextMenuElement.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import UIKit

public protocol ContextMenuElement: BaseMenuMenuElement, IdentifiableMenuElement, MenuElementContainer {

    var previewProvider: ContextMenu.PreviewProvider? { get set }
    var previewCommitter: ContextMenu.PreviewCommitter? { get set }
    var previewCommitStyle: UIContextMenuInteractionCommitStyle { get set }
    var targetedHighlightPreviewProvider: ContextMenu.TargetedPreviewProvider? { get set }
    var targetedDismissPreviewProvider: ContextMenu.TargetedPreviewProvider? { get set }
    var includeSuggestedElements: Bool { get set }
    var willPresent: (()->())? { get set }
    var willDismiss: (()->())? { get set }
    
}
