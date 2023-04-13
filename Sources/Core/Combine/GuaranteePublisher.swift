//
//  GuaranteePublisher.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine

/// A publisher that can never fail.
public typealias GuaranteePublisher<Output> = AnyPublisher<Output, Never>
