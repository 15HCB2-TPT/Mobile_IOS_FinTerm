//
//  GenericTypeHelper.swift
//  BT_CoreData
//
//  Created by Hiroshi.Kazuo on 3/25/17.
//  Copyright © 2017 Hiroshi.Kazuo. All rights reserved.
//

import Foundation

class GenericTypeHelper<T> {
    static func genericName() -> String {
        return "\(T.self)".characters.split(separator: ".").map(String.init).last!
    }
    
    static func genericFullName() -> String {
        return "\(T.self)"
    }
}
