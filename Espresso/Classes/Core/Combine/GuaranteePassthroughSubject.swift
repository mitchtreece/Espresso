//
//  GuaranteePassthroughSubject.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine

/// A subject that outputs elements to downstream subscribers, and can never fail.
public typealias GuaranteePassthroughSubject<Output> = PassthroughSubject<Output, Never>
