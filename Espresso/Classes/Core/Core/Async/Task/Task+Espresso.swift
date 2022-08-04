//
//  Task+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import Foundation

public extension Task where Success == Never, Failure == Never {
    
    /// Suspends the current task for at least the given duration.
    ///
    /// - parameter duration: The sleep duration.
    ///
    /// If the task is canceled before the time ends, this function throws CancellationError.
    /// This function doesn’t block the underlying thread.
    static func sleep(duration: TimeDuration) async throws {

        let nanoseconds = duration
            .convert(to: .nanoseconds)
            .value
        
        try await Task.sleep(nanoseconds: UInt64(nanoseconds))
        
    }
    
}
