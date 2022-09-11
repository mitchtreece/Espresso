//
//  CancellableBag.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine

/// Combine cancellable storage that cancels added items on `deinit`.
///
/// In case contained cancellables need to be manually cancelled,
/// change the bag's value, or create a new one in its place.
///
///     self.bag = CancellableBag()
public typealias CancellableBag = Set<AnyCancellable>
