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
