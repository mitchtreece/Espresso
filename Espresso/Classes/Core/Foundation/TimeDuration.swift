//
//  TimeDuration.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import Foundation

/// A number of seconds, millisconds, microseconds, or nanoseconds.
public typealias TimeDuration = DispatchTimeInterval

public extension TimeDuration {
    
    /// Representation of the various second scales.
    enum Representation {
        
        /// A second representation.
        ///
        /// Seconds * 1
        case seconds
        
        /// A millisecond representation.
        ///
        /// Seconds * 0.001
        case milliseconds
        
        /// A microsecond representation.
        ///
        /// Seconds * 0.000001
        case microseconds
        
        /// A nanosecond representation.
        ///
        /// Seconds *  0.000000001
        case nanoseconds
        
    }
    
    /// Converts a time duration to a different representation.
    /// - Parameters representation: The representation to convert to.
    /// _ Returns: A converted time duration as a `TimeInterval`.
    func convert(to representation: Representation) -> TimeInterval {
        
        switch representation {
        case .seconds:
                        
            switch self {
            case .seconds(let sec): return TimeInterval(sec)
            case .milliseconds(let milli): return TimeInterval(milli) * 0.001
            case .microseconds(let micro): return TimeInterval(micro) * 0.000001
            case .nanoseconds(let nano): return TimeInterval(nano) * 0.000000001
            case .never: return 0
            @unknown default: return 0
            }
        
        case .milliseconds:
            
            switch self {
            case .seconds(let sec): return TimeInterval(sec) * 1_000
            case .milliseconds(let milli): return TimeInterval(milli)
            case .microseconds(let micro): return (TimeInterval(micro) / 1_000)
            case .nanoseconds(let nano): return (TimeInterval(nano) / 1_000_000)
            case .never: return 0
            @unknown default: return 0
            }
            
        case .microseconds:
            
            switch self {
            case .seconds(let sec): return (TimeInterval(sec) * 1_000_000)
            case .milliseconds(let milli): return (TimeInterval(milli) * 1_000)
            case .microseconds(let micro): return TimeInterval(micro)
            case .nanoseconds(let nano): return (TimeInterval(nano) / 1_000)
            case .never: return 0
            @unknown default: return 0
            }
            
        case .nanoseconds:
            
            switch self {
            case .seconds(let sec): return (TimeInterval(sec) * 1_000_000_0000)
            case .milliseconds(let milli): return (TimeInterval(milli) * 1_000_000)
            case .microseconds(let micro): return (TimeInterval(micro) * 1_000)
            case .nanoseconds(let nano): return TimeInterval(nano)
            case .never: return 0
            @unknown default: return 0
            }
            
        }
        
    }
    
}

public extension TimeInterval {
    
    /// Initializes a time interval with a time duration.
    /// - Parameter duration: A time duration.
    init(duration: TimeDuration) {
        
        switch duration {
        case .seconds(let sec): self = TimeInterval(sec)
        case .milliseconds(let milli): self = (TimeInterval(milli) / 1_000)
        case .microseconds(let micro): self = (TimeInterval(micro) / 1_000_000)
        case .nanoseconds(let nano): self = (TimeInterval(nano) / 1_000_000_000)
        case .never: self = 0
        @unknown default: self = 0
        }
        
    }
    
}
