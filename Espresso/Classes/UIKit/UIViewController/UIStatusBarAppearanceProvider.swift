//
//  UIStatusBarAppearanceProvider.swift
//  Espresso
//
//  Created by Mitch Treece on 12/18/17.
//

import UIKit

public typealias UIStatusBarAppearance = (
    style: UIStatusBarStyle,
    hidden: Bool,
    animation: UIStatusBarAnimation
)

public protocol UIStatusBarAppearanceProvider {
    var preferredStatusBarAppearance: UIStatusBarAppearance { get }
}
