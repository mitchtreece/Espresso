//
//  DispatchQueue+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 7/26/22.
//

import Foundation

public extension DispatchQueue {
    
    /// Schedules a block of work for execution using the specified attributes & delay.
    /// - parameter delay: The delay to use when scheduling the work.
    /// - parameter qos: The quality of service (priority) to use when scheduling the work; _defaults to `unspecified`_.
    /// - parameter flags: The item flags to use when scheduling the work; _defaults to none_.
    /// - parameter work: The work execution block.
    func asyncAfter(delay: TimeDuration,
                    qos: DispatchQoS = .unspecified,
                    flags: DispatchWorkItemFlags = [],
                    execute work: @escaping ()->()) {

        asyncAfter(
            deadline: .now() + delay.asDispatchInterval(),
            qos: qos,
            flags: flags,
            execute: work
        )

    }
    
}
