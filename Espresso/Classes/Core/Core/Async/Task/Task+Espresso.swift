//
//  Task+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import Foundation

public extension Task where Success == Never, Failure == Never {
    
    static func sleep(duration: TimeDuration) async {
        
        do {
            try await sleepThrowing(duration: duration)
        }
        catch {
            //
        }
        
    }
    
    static func sleepThrowing(duration: TimeDuration) async throws {
        
        let nanoseconds = duration.convert(to: .nanoseconds)
        try await Task.sleep(nanoseconds: UInt64(nanoseconds))
        
    }
    
}
