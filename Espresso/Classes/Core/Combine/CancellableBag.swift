//
//  CancellableBag.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine

/// Cancellable storage that cancels added items when removed, _or_ on `deinit`.
///
/// In case contained cancellables need to be manually cancelled,
/// change the bag's value, or create a new one in its place.
public typealias CancellableBag = Set<AnyCancellable>
