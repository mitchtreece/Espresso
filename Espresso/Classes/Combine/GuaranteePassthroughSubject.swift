//
//  GuaranteePassthroughSubject.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine

/// A subject that broadcasts elements to downstream subscribers without failure.
@available(iOS 13, *)
public typealias GuaranteePassthroughSubject<Output> = PassthroughSubject<Output, Never>
