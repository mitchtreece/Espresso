//
//  UIButton+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 1/10/23.
//

import Foundation

private struct AssociatedKeys {
    static var extendedEdgeInset: UInt8 = 0
}

public extension UIButton /* Extended Edges */ {

    /// The button's extended (tappable) edge inset.
    var extendedEdgeInset: CGFloat? {
        get {
            associatedObject(forKey: AssociatedKeys.extendedEdgeInset) as? CGFloat
        }
        set {
            setAssociatedObject(newValue, forKey: AssociatedKeys.extendedEdgeInset)
        }
    }
    
    override func point(inside point: CGPoint,
                        with event: UIEvent?) -> Bool {

        guard let inset = self.extendedEdgeInset else {
            return super.point(inside: point, with: event)
        }

        return bounds.insetBy(
            dx: -inset,
            dy: -inset
        )
        .contains(point)

    }

}
