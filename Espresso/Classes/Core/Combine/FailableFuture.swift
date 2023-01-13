//
//  FailableFuture.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import Combine

/// A publisher that eventually produces a single value, and then finishes or fails.
public typealias FailableFuture<T> = Future<T, Error>
