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
    /// - Parameter name: The storyboard's name; _defaults to \"Main\"_.
    /// - Parameter identifier: The view controller's storyboard identifier. If no identifier is provided, the class name will be used; _defaults to nil_.
    /// - Returns: A typed storyboard-loaded view controller instance.
    static func initFromStoryboard(named name: String = "Main", identifier: String? = nil) -> Self? {
        
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let identifier = identifier ?? self.staticIdentifier
        return storyboard.instantiateViewController(withIdentifier: identifier) as? Self
        
    }
    
}
