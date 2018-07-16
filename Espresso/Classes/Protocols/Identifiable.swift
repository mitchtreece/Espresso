//
//  Identifiable.swift
//  Espresso
//
//  Created by Mitch Treece on 1/27/18.
//

import UIKit

/**
 Protocol that describes a way to identify an object at a class-level.
 */
public protocol Identifiable {
    
    /**
     The class's string identifier.
     */
    static var identifier: String { get }
    
}

public extension Identifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UIView: Identifiable {}
extension UIViewController: Identifiable {}

extension Identifiable where Self: UIViewController {
    
    /**
     Initializes a new instance of the view controller from a storyboard. If no name is provided, _\"Main\"_ will be used.
     
     - Parameter name: The storyboard's name.
     - Returns: A typed storyboard-loaded view controller instance.
     */
    public static func initFromStoryboard(named name: String = "Main") -> Self? {
        
        let sb = UIStoryboard(name: name, bundle: nil)
        return (sb.instantiateViewController(withIdentifier: Self.identifier) as? Self)
        
    }
    
}
