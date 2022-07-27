//
//  Task+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    
    static func sleep(duration: TimeDuration) async throws {
        
        let nanoseconds = duration.convert(to: .nanoseconds)
        try await Task.sleep(nanoseconds: UInt64(nanoseconds))
        
    }
    
}
