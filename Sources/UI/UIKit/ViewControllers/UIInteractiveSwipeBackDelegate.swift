//
//  UIInteractiveSwipeBackDelegate.swift
//  Espresso
//
//  Created by Mitch Treece on 9/11/22.
//

import UIKit

internal final class UIInteractiveSwipeBackDelegate: NSObject,
                                                     UIGestureRecognizerDelegate {

    weak var navigationController: UINavigationController?
    weak var originalGestureDelegate: UIGestureRecognizerDelegate?

    var isGestureEnabled: Bool = true

    override func responds(to aSelector: Selector!) -> Bool {

        if #available(iOS 13.4, *) {
            return self.originalGestureDelegate?.responds(to: aSelector) ?? false
        }
        else if aSelector == #selector(gestureRecognizer(_:shouldReceive:)) {
            return true
        }
        else if let responds = self.originalGestureDelegate?.responds(to: aSelector) {
            return responds
        }

        return false

    }

    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        self.originalGestureDelegate
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {

        if let nav = self.navigationController,
            nav.isNavigationBarHidden,
            nav.viewControllers.count > 1 {

            if self.isGestureEnabled {
                return true
            }

            return false

        }
        else if let result = self.originalGestureDelegate?.gestureRecognizer?(gestureRecognizer, shouldReceive: touch) {
            return result
        }

        return false

    }

    @objc private func _gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                          shouldReceiveEvent event: UIEvent) -> Bool {

        // NOTE: This is a PRIVATE function that we are overriding.
        // This is called on iOS 13.4 and up when trying to decide
        // if the pop back gesture should begin. On previous iOS
        // versions, the normal `gestureRecognizer(gestureRecognizer:shouldReceive:)`
        // delegate function.

        if let nav = self.navigationController,
            nav.isNavigationBarHidden,
            nav.viewControllers.count > 1 {

            if self.isGestureEnabled {
                return true
            }

            return false

        }
        else if let originalDelegate = self.originalGestureDelegate {

            let selector = #selector(self._gestureRecognizer(_:shouldReceiveEvent:))

            if originalDelegate.responds(to: selector) {

                let result = originalDelegate.perform(
                    selector,
                    with: gestureRecognizer,
                    with: event
                )

                return result != nil

            }

        }

        return false

    }

}
