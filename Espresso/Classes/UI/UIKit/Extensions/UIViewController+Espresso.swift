//
//  UIViewController+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 2/16/19.
//

import UIKit

extension UIViewController: StaticIdentifiable {}

public extension StaticIdentifiable where Self: UIViewController /* Storyboard */ {
    
    /// Initializes a new instance of the view controller from a storyboard.
    ///
    /// - parameter name: The storyboard's name; _defaults to \"Main\"_.
    /// - parameter identifier: The view controller's storyboard identifier.
    ///                         If no identifier is provided, the class name will be used; _defaults to nil_.
    /// - returns: A typed storyboard-loaded view controller instance.
    static func initFromStoryboard(named name: String = "Main", identifier: String? = nil) -> Self? {
        
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let identifier = identifier ?? self.staticIdentifier
        return storyboard.instantiateViewController(withIdentifier: identifier) as? Self
        
    }
    
}

public extension UIViewController /* Modal */ {
    
    /// Presents a view controller modally, awaiting presentation completion.
    /// - parameter viewController: The view controller to present.
    ///
    /// This is always performed with animations.
    func present(_ viewController: UIViewController) async {
        
        await withCheckedContinuation { c in
            present(viewController, animated: true) {
                c.resume()
            }
        }
        
    }
    
    /// Dismisses the view controller that was presented modally by the
    /// view controller, awaiting dismissal completion.
    ///
    /// This is always performed with animations.
    func dismiss() async {
        
        await withCheckedContinuation { c in
            dismiss(animated: true) {
                c.resume()
            }
        }
        
    }
    
}

public extension UIViewController /* Navigation */ {
    
    /// Flag indicating if the view-controller is embedded in a `UINavigationController`
    /// stack **and** is not the stack's root view-controller.
    var isNavigationPoppable: Bool {

        if let nav = self.navigationController,
           nav.viewControllers.count > 1 { return true }

        return false
        
    }
    
}
