//
//  FailablePublisher.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import Combine

/// A publisher that can fail.
public typealias FailablePublisher<Output> = AnyPublisher<Output, Error>
