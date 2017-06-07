//
//  NSDateCompare.swift
//  QuanLyThuChi
//
//  Created by Hiroshi.Kazuo on 6/6/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import Foundation

extension NSDate {
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        return self.compare(dateToCompare as Date) == ComparisonResult.orderedDescending
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        return self.compare(dateToCompare as Date) == ComparisonResult.orderedAscending
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        return self.compare(dateToCompare as Date) == ComparisonResult.orderedSame
    }
    
    func add(value: Int, com: Calendar.Component) -> NSDate {
        //        let seconds: TimeInterval = Double(value) * 60 * 60 * 24 * 365
        //        return self.addingTimeInterval(seconds)
        let calendar = NSCalendar.current
        var components = calendar.dateComponents([.era, .year, .month, .day, .hour, .minute, .second, .nanosecond, .quarter, .timeZone, .weekday, .weekOfYear, .weekOfMonth, .weekdayOrdinal, .calendar, .yearForWeekOfYear], from: self as Date)
        components.setValue(components.value(for: com)! + value, for: com)
        return calendar.date(from: components)! as NSDate
    }
    
    static func calicuateDaysBetweenTwoDates(start: NSDate, end: NSDate, com: Calendar.Component) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: com, in: .era, for: start as Date) else {
            return 0
        }
        guard let end = currentCalendar.ordinality(of: com, in: .era, for: end as Date) else {
            return 0
        }
        return end - start
    }
}
