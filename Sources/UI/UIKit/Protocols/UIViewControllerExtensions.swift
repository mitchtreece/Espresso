//
//  UIViewControllerExtended.swift
//  Espresso
//
//  Created by Mitch on 12/19/24.
//

#if canImport(UIKit)

import UIKit
import Espresso

/// Protocol describing common characteristics
/// of an extended view controller.
public protocol UIViewControllerCommon: Binder, ComponentBinder where Self: UIViewController {}

public extension UIViewControllerCommon {
    
    /// The view controller's extended navigation controller.
    var navigationControllerEx: UINavigationControllerEx? {
        
        if self is UINavigationController {
            return self as? UINavigationControllerEx
        }
        
        return self.navigationController as? UINavigationControllerEx
        
    }
    
    /// The view controller's window safe-area insets.
    ///
    /// The value of this property is pulled directly from
    /// the view controller's parent `UIWindow`, or the application's
    /// key scene window. This property is always accessible, unlike
    /// `self.view.safeAreaInsets` which can have invalid values early
    /// on in the view lifecycle.
    var safeAreaWindowInsets: UIEdgeInsets {
        
        let window =  self.view.window ?? UIApplication.shared.keySceneWindow
        return window?.safeAreaInsets ?? self.view.safeAreaInsets
        
    }
    
}

public protocol UIViewControllerLifecycle where Self: UIViewController {
    
    /// A publisher that sends when the view controller's
    /// view finishes loading.
    var onViewDidLoad: GuaranteePublisher<Void> { get }
    
    /// A publisher that sends when the view controller's
    /// view is about to appear.
    var onViewWillAppear: GuaranteePublisher<Bool> { get }
    
    /// A publisher that sends when the view controller's
    /// view has finished its layout pass, and is appearing.
    var onViewIsAppearing: GuaranteePublisher<Bool> { get }
    
    /// A publisher that sends when the view controller's
    /// view is about to layout its subviews.
    var onViewWillLayoutSubviews: GuaranteePublisher<Void> { get }
    
    /// A publisher that sends when the view controller's
    /// view finishes laying out its subviews.
    var onViewDidLayoutSubviews: GuaranteePublisher<Void> { get }
    
    /// A publisher that sends when the view controller's
    /// view has finished its initial layout, and has fully
    /// loaded its geometry.
    var onViewDidLoadGeometry: GuaranteePublisher<Void> { get }
    
    /// A publisher that sends when the view controller's
    /// view has updated its layout, and has fully loaded
    /// its geometry.
    var onViewDidUpdateGeometry: GuaranteePublisher<Bool> { get }
    
    /// A publisher that sends when the view controller's
    /// view finishes appearing.
    var onViewDidAppear: GuaranteePublisher<Bool> { get }
    
    /// A publisher that sends when the view controller's
    /// view is about to disappear.
    var onViewWillDisappear: GuaranteePublisher<Bool> { get }
    
    /// A publisher that sends when the view controller's
    /// view finishes disappearing.
    var onViewDidDisappear: GuaranteePublisher<Bool> { get }
    
    /// A publisher that sends when the view controller
    /// receives a memory warning.
    var onDidRecieveMemoryWarning: GuaranteePublisher<Void> { get }
    
    /// Notifies the view controller that the system has finished
    /// loading its view's initial layout & geometry.
    ///
    /// This is scheduled from `viewWillAppear` on the view controller's
    /// first-appearance, and is only ever called once.
    ///
    /// This is scheduled from `viewWillAppear` instead of `viewDidLoad`
    /// so it can be grouped into the same appearance transaction as the other
    /// appearance-based lifecycle functions.
    func viewDidLoadGeometry()
    
    /// Notifies the view controller that the system has finished
    /// updating its view's layout & geometry.
    ///
    /// This is scheduled from `viewIsAppearing`, and is called
    /// during each appearance cycle.
    func viewDidUpdateGeomtery(_ animated: Bool)
    
}

public protocol UIViewControllerAppearance: UIUserInterfaceStyleAdaptable where Self: UIViewController {
        
    /// Flag indicating if this is the view controller's first appearance.
    ///
    /// This will only be `true` until the view controller's
    /// `viewDidAppear(_:)` function is called for the first time.
    var isFirstAppearance: Bool { get }
    
    /// Flag indicating if the view controller has a modal-sheet presentation style.
    var isInModalSheetPresentation: Bool { get }
    
    /// The view controller's modal style.
    var modalStyle: UIModalStyle { get set }
    
    /// Flag indicating if interactive swipe-back (pop) gesture
    /// handling is enabled for this view controller.
    var isSwipeBackGestureEnabled: Bool { get set }
    
    /// Flag indicating if the view controller should hide its
    /// navigation bar on appearance.
    var prefersNavigationBarHidden: Bool { get set }
    
    /// Flag indicating if the view controller enforces modal-behavior,
    /// or supports interactive dismissal.
    @available(iOS 13, *)
    var isInteractiveModalDismissEnabled: Bool { get set }
    
}

#endif
