//
//  FailablePassthroughSubject.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import Combine

/// A subject that outputs elements to downstream subscribers, and can fail.
public typealias FailablePassthroughSubject<Output> = PassthroughSubject<Output, Error>
