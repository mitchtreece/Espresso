//
//  TimeDuration.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import Foundation

/// A duration of seconds, millisconds, microseconds, or nanoseconds.
public typealias TimeDuration = DispatchTimeInterval

public extension TimeDuration {
    
    /// Representation of the various time duration units.
    enum Unit {
        
        /// A second unit.
        ///
        /// `Seconds * 1`
        case seconds
        
        /// A millisecond unit.
        ///
        /// `Seconds * 1,000`
        case milliseconds
        
        /// A microsecond unit.
        ///
        /// `Seconds * 1,000,000`
        case microseconds
        
        /// A nanosecond unit.
        ///
        /// `Seconds * 1,000,000,000`
        case nanoseconds
        
    }
    
    /// The duration's value.
    ///
    /// `seconds(1) = 1`
    ///
    /// `milliseconds(1000) = 1000`
    ///
    /// `microseconds(1000000) = 1000000`
    ///
    /// `nanoseconds(1000000000) = 1000000000`
    var value: Int {
        
        switch self {
        case .seconds(let value): return value
        case .milliseconds(let value): return value
        case .microseconds(let value): return value
        case .nanoseconds(let value): return value
        default: return 0
        }
        
    }
    
    /// Converts the duration to a new duration using a given unit.
    ///
    /// - parameter unit: The unit to convert the duration to.
    /// - returns: A unit-converted `TimeDuration`.
    ///
    /// ```
    /// seconds(1).convert(to: .milliseconds) -> milliseconds(1000)
    /// milliseconds(1000).convert(to: .seconds) -> seconds(1)
    /// ```
    func convert(to unit: Unit) -> TimeDuration {
        
        switch self {
        case .seconds(let value):
                        
            switch unit {
            case .seconds:      return self
            case .milliseconds: return .milliseconds(value * 1_000)
            case .microseconds: return .microseconds(value * 1_000_000)
            case .nanoseconds:  return .nanoseconds(value * 1_000_000_000)
            }
            
        case .milliseconds(let value):
            
            switch unit {
            case .seconds:      return .seconds(value / 1_000)
            case .milliseconds: return self
            case .microseconds: return .microseconds(value * 1_000)
            case .nanoseconds:  return .nanoseconds(value * 1_000_000)
            }
            
        case .microseconds(let value):
            
            switch unit {
            case .seconds:      return .seconds(value / 1_000_000)
            case .milliseconds: return .milliseconds(value / 1_000)
            case .microseconds: return self
            case .nanoseconds:  return .nanoseconds(value * 1_000)
            }
            
        case .nanoseconds(let value):
            
            switch unit {
            case .seconds:      return .seconds(value / 1_000_000_000)
            case .milliseconds: return .milliseconds(value / 1_000_000)
            case .microseconds: return .microseconds(value / 1_000)
            case .nanoseconds:  return self
            }
            
        default: return .never
        }
        
    }
    
    /// A `TimeInterval` representation of this duration.
    ///
    /// - returns: A `TimeInterval` value.
    ///
    /// `TimeInterval` is a seconds-relative representation of time measurement.
    /// Converting a duration to an interval will reframe the duration's value
    /// in terms of seconds.
    ///
    /// ```
    /// seconds(1).asInterval()      -> TimeInterval(1)
    /// milliseconds(1).asInterval() -> TimeInterval(0.001)
    /// microseconds(1).asInterval() -> TimeInterval(0.00001)
    /// nanoseconds(1).asInterval()  -> TimeInterval(0.000000001)
    /// ```
    func asInterval() -> TimeInterval {
        
        switch self {
        case .seconds(let value):      return TimeInterval(value)
        case .milliseconds(let value): return TimeInterval(value) / 1_000
        case .microseconds(let value): return TimeInterval(value) / 1_000_000
        case .nanoseconds(let value):  return TimeInterval(value) / 1_000_000_000
        case .never: fallthrough
        @unknown default: return 0
        }

    }
    
}
