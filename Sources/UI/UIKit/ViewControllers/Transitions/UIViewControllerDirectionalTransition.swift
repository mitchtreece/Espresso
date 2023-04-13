//
//  UIViewControllerDirectionalTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/21.
//

import UIKit

/// Directional view controller transition base class.
public class UIViewControllerDirectionalTransition: UIViewControllerTransition  {
    
    /// The transition's presentation direction.
    public var presentationDirection: Direction = .left
    
    /// The transition's dismissal direction.
    public var dismissalDirection: Direction = .right
    
}
