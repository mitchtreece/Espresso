//
//  GuaranteeFuture.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import Combine

/// A publisher that eventually produces a single value, and then finishes without failure.
public typealias GuaranteeFuture<T> = Future<T, Never>
