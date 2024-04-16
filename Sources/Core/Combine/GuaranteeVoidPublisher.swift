//
//  GuaranteeVoidPublisher.swift
//  Espresso
//
//  Created by Mitch Treece on 4/16/24.
//

import Combine

/// A publisher that outputs `Void` values, and can never fail.
public typealias GuaranteeVoidPublisher = AnyPublisher<Void, Never>
