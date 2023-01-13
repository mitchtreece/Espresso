//
//  DataAction.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import Foundation

/// An action that provides a single value, and returns nothing.
public typealias Action<T> = (T)->()

/// An action that provides two values, and returns nothing.
public typealias Action2<T, U> = (T, U)->()

/// An action that provides three values, and returns nothing.
public typealias Action3<T, U, V> = (T, U, V)->()
