//
//  FailableVoidPublisher.swift
//  Espresso
//
//  Created by Mitch Treece on 4/16/24.
//

import Combine

/// A publisher that outputs `Void` values, and can fail.
public typealias FailableVoidPublisher = AnyPublisher<Void, Error>
