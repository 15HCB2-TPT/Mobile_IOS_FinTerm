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
    
    func addYears(value: Int) -> NSDate {
        let seconds: TimeInterval = Double(value) * 60 * 60 * 24 * 365
        return self.addingTimeInterval(seconds)
    }
    
    func addMonths(value: Int) -> NSDate {
        let seconds: TimeInterval = Double(value) * 60 * 60 * 24 * 31
        return self.addingTimeInterval(seconds)
    }

    func addDays(value: Int) -> NSDate {
        let seconds: TimeInterval = Double(value) * 60 * 60 * 24
        return self.addingTimeInterval(seconds)
    }

    func addHours(value: Int) -> NSDate {
        let seconds: TimeInterval = Double(value) * 60 * 60
        return self.addingTimeInterval(seconds)
    }
    
    static func calicuateDaysBetweenTwoDates(start: NSDate, end: NSDate) -> Int {
        let currentCalendar = Calendar.current
        guard let start = currentCalendar.ordinality(of: .day, in: .era, for: start as Date) else {
            return 0
        }
        guard let end = currentCalendar.ordinality(of: .day, in: .era, for: end as Date) else {
            return 0
        }
        return end - start
    }
}
