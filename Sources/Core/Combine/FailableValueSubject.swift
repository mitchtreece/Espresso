//
//  FailableValueSubject.swift
//  Espresso
//
//  Created by Mitch Treece on 9/13/22.
//

import Combine

/// A subject that outputs an initial value, and all future values to downstream subscribers, and can fail.
public typealias FailableValueSubject<Output> = CurrentValueSubject<Output, Error>
