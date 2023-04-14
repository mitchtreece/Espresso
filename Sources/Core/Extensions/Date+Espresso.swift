//
//  Date+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 7/9/18.
//

import Foundation

public extension Date /* Arithmetic */ {
    
    /// Creates a new date by adding a component-value to the reciever.
    /// - Parameter component: The calendar component to add.
    /// - Parameter value: The value to add to the date.
    /// - Returns: A new date by adding the specified component-value.
    func byAdding(_ component: Calendar.Component, value: Int) -> Date? {
        return Calendar.current.date(byAdding: component, value: value, to: self)
    }
    
}

public extension Date /* Since */ {
    
    typealias DateInterval = (years: Int, days: Int, hours: Int, minutes: Int, seconds: Int)
    
    /// Gets the date interval between the reciever and a specified date.
    /// - Parameter date: The date.
    /// - Returns: A date interval.
    func dateIntervalSince(_ date: Date) -> DateInterval {
        
        let components = Calendar.current.dateComponents([.year, .day, .hour, .minute, .second], from: date, to: self)
        
        return (
            years: components.year ?? 0,
            days: components.day ?? 0,
            hours: components.hour ?? 0,
            minutes: components.minute ?? 0,
            seconds: components.second ?? 0
        )
        
    }
    
    /// Gets the date interval between the reciever and the current date.
    /// - Returns: A date interval.
    func dateIntervalSinceNow() -> DateInterval {
        return self.dateIntervalSince(Date())
    }
    
    /// Gets the number of seconds between the reciever and a specified date.
    /// - Parameter date: The date.
    /// - Returns: An `Int` number of seconds.
    func seconds(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.second], from: date, to: self).second
    }
    
    /// Gets the number of seconds between the reciever and the current date.
    /// - Returns: An `Int` number of seconds.
    func secondsSinceNow() -> Int? {
        return self.seconds(since: Date())
    }
    
    /// Gets the number of minutes between the reciever and a specified date.
    /// - Parameter date: The date.
    /// - Returns: An `Int` number of minutes.
    func minutes(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute
    }
    
    /// Gets the number of minutes between the reciever and the current date.
    /// - Returns: An `Int` number of minutes.
    func minutesSinceNow() -> Int? {
        return self.minutes(since: Date())
    }
    
    /// Gets the number of hours between the reciever and a specified date.
    /// - Parameter date: The date.
    /// - Returns: An `Int` number of hours.
    func hours(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour
    }
    
    /// Gets the number of hours between the reciever and the current date.
    /// - Returns: An `Int` number of hours.
    func hoursSinceNow() -> Int? {
        return self.hours(since: Date())
    }
    
    /// Gets the number of days between the reciever and a specified date.
    /// - Parameter date: The date.
    /// - Returns: An `Int` number of days.
    func days(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: date, to: self).day
    }
    
    /// Gets the number of days between the reciever and the current date.
    /// - Returns: An `Int` number of days.
    func daysSinceNow() -> Int? {
        return self.days(since: Date())
    }
    
    /// Gets the number of weeks between the reciever and a specified date.
    /// - Parameter date: The date.
    /// - Returns: An `Int` number of weeks.
    func weeks(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear
    }
    
    /// Gets the number of weeks between the reciever and the current date.
    /// - Returns: An `Int` number of weeks.
    func weeksSinceNow() -> Int? {
        return self.weeks(since: Date())
    }
    
    /// Gets the number of months between the reciever and a specified date.
    /// - Parameter date: The date.
    /// - Returns: An `Int` number of months.
    func months(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.month], from: date, to: self).month
    }
    
    /// Gets the number of months between the reciever and the current date.
    /// - Returns: An `Int` number of months.
    func monthsSinceNow() -> Int? {
        return self.months(since: Date())
    }
    
    /// Gets the number of years between the reciever and a specified date.
    /// - Parameter date: The date.
    /// - Returns: An `Int` number of years.
    func years(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.year], from: date, to: self).year
    }
    
    /// Gets the number of years between the reciever and the current date.
    /// - Returns: An `Int` number of years.
    func yearsSinceNow() -> Int? {
        return self.years(since: Date())
    }
    
}
