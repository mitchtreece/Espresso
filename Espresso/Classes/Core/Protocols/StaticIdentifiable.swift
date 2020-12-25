//
//  StaticIdentifiable.swift
//  Espresso
//
//  Created by Mitch Treece on 1/27/18.
//

import UIKit

/// Protocol that describes a way to identify an object statically.
public protocol StaticIdentifiable {
    
    /// The object's static identifier.
    static var staticIdentifier: String { get }
    
}

public extension StaticIdentifiable {
    
    static var staticIdentifier: String {
        return String(describing: self)
    }
    
}

extension UIView: StaticIdentifiable {}
extension UIViewController: StaticIdentifiable {}
