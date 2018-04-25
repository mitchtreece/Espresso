//
//  Identifiable.swift
//  Espresso
//
//  Created by Mitch Treece on 1/27/18.
//

import UIKit

public protocol Identifiable {
    static var identifier: String { get }
}

public extension Identifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UIView: Identifiable {}
extension UIViewController: Identifiable {}
