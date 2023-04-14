//
//  TimeDuration.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import Foundation

/// A duration of seconds, millisconds, microseconds, or nanoseconds.
public enum TimeDuration {
    
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
    
    /// A number of seconds.
    case seconds(Double)
    
    /// A number of milliseconds.
    case milliseconds(Double)
    
    /// A number of microseconds.
    case microseconds(Double)
    
    /// A number of nanoseconds.
    case nanoseconds(Double)
    
    /// The duration's value.
    ///
    /// `seconds(1) = 1`
    ///
    /// `milliseconds(1000) = 1000`
    ///
    /// `microseconds(1000000) = 1000000`
    ///
    /// `nanoseconds(1000000000) = 1000000000`
    var value: Double {
        
        switch self {
        case .seconds(let value): return value
        case .milliseconds(let value): return value
        case .microseconds(let value): return value
        case .nanoseconds(let value): return value
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
        case .seconds(let value):      return value
        case .milliseconds(let value): return value / 1_000
        case .microseconds(let value): return value / 1_000_000
        case .nanoseconds(let value):  return value / 1_000_000_000
        }

    }
    
    /// A `DispatchTimeInterval` representation of this duration.
    ///
    /// - returns: A `DispatchTimeInterval` value.
    ///
    /// This casts the duration's value to an `Int` in order to be
    /// compatible with `DispatchTimeInterval`. Floating point
    /// precision will be lost.
    ///
    /// ```
    /// seconds(1).asDispatchInterval()              -> seconds(1)
    /// milliseconds(1000).asDispatchInterval()      -> milliseconds(1000)
    /// microseconds(1000000).asDispatchInterval()   -> microseconds(1000000)
    /// nanoseconds(1000000000).asDispatchInterval() -> nanoseconds(1000000000)
    /// ```
    func asDispatchInterval() -> DispatchTimeInterval {
        
        switch self {
        case .seconds(let value):      return .seconds(Int(value))
        case .milliseconds(let value): return .milliseconds(Int(value))
        case .microseconds(let value): return .microseconds(Int(value))
        case .nanoseconds(let value):  return .nanoseconds(Int(value))
        }
        
    }
    
}

public extension TimeInterval {
    
    /// A `TimeDuration` representation of this interval.
    func asDuration() -> TimeDuration {
        return .seconds(self)
    }
    
}
