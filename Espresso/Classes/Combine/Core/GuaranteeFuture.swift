//
//  GuaranteeFuture.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import Combine

/// A publisher that produces a single value without failure.
public typealias GuaranteeFuture<T> = Future<T, Never>
