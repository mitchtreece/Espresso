//
//  UIViewController+StaticIdentifiable.swift
//  Espresso
//
//  Created by Mitch Treece on 2/19/24.
//

#if canImport(UIKit)

import Espresso

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

#endif
