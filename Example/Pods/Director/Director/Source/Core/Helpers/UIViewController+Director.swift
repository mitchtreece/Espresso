//
//  UIViewController+Director.swift
//  Director
//
//  Created by Mitch Treece on 6/6/19.
//

import UIKit

internal extension UIViewController /* Active */ {
    
    static func active(in base: UIViewController?) -> UIViewController? {
        
        if let presentedViewController = base?.presentedViewController {
            return active(in: presentedViewController)
        }
        else if let nav = base as? UINavigationController, let visibleViewController = nav.visibleViewController {
            return active(in: visibleViewController)
        }
        else if let tab = base as? UITabBarController, let selectedViewController = tab.selectedViewController {
            return active(in: selectedViewController)
        }
        
        return base
        
    }
    
    static func root(in base: UIViewController?) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return nav.viewControllers.first
        }
        
        return base
        
    }
    
}

internal extension UIViewController /* Presentation Delegate */ {
    
    private struct AssociatedKey {
        static var viewCoordinatorPresentationDelegate: UInt = 0
    }
    
    var viewCoordinatorPresentationDelegate: ViewCoordinatorPresentationDelegate? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.viewCoordinatorPresentationDelegate) as? ViewCoordinatorPresentationDelegate
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.viewCoordinatorPresentationDelegate, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

internal extension UIViewController /* Swizzle */ {
    
    @objc private func swizzled_viewDidDisappear(_ animated: Bool) {
        
        self.swizzled_viewDidDisappear(animated)
        
        if self.isBeingDismissed {
            self.viewCoordinatorPresentationDelegate?.viewControllerIsBeingDismissed(self)
        }
        
    }
    
    static func director_swizzle() {
        
        guard self === UIViewController.self else { return }
        
        let _: () = {
            let oSel = #selector(viewDidDisappear(_:))
            let sSel = #selector(swizzled_viewDidDisappear(_:))
            let oMeth = class_getInstanceMethod(self, oSel)
            let sMeth = class_getInstanceMethod(self, sSel)
            method_exchangeImplementations(oMeth!, sMeth!)
        }()
        
    }
    
}
