//
//  RandomSwift3.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/18/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

import Foundation

private let _wordSize = __WORDSIZE

public extension UInt32 {
    public static func random(lower: UInt32 = min, upper: UInt32 = max) -> UInt32 {
        return arc4random_uniform(upper - lower) + lower
    }
}

public extension Int32 {
    public static func random(lower: Int32 = min, upper: Int32 = max) -> Int32 {
        let r = arc4random_uniform(UInt32(Int64(upper) - Int64(lower)))
        return Int32(Int64(r) + Int64(lower))
    }
}

public extension UInt64 {
    public static func random(lower: UInt64 = min, upper: UInt64 = max) -> UInt64 {
        return UInt64(arc4random_uniform(UInt32(upper - lower)) + UInt32(lower))
    }
}

public extension Int64 {
    public static func random(lower: Int64 = min, upper: Int64 = max) -> Int64 {
        let r = arc4random_uniform(UInt32(Int64(upper) - Int64(lower)))
        return Int64(r) + Int64(lower)
    }
}

public extension UInt {
    public static func random(lower: UInt = min, upper: UInt = max) -> UInt {
        switch (_wordSize) {
            case 32: return UInt(UInt32.random(lower: UInt32(lower), upper: UInt32(upper)))
            case 64: return UInt(UInt64.random(lower: UInt64(lower), upper: UInt64(upper)))
            default: return lower
        }
    }
}

public extension Int {
    public static func random(lower: Int = min, upper: Int = max) -> Int {
        switch (_wordSize) {
            case 32: return Int(Int32.random(lower: Int32(lower), upper: Int32(upper)))
            case 64: return Int(Int64.random(lower: Int64(lower), upper: Int64(upper)))
            default: return lower
        }
    }
}
