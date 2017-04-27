//
//  TempData.swift
//  QuanLyQuanAn
//
//  Created by Hiroshi.Kazuo on 4/21/17.
//  Copyright © 2017 Shin-MacDesk. All rights reserved.
//

struct TempData {
    fileprivate static var _tempData = [String: Any]()
    
    static func save(_ value: Any, forKey: String) {
        _tempData.updateValue(value, forKey: forKey)
    }
    
    static func load(fromKey: String) -> Any? {
        let value = _tempData[fromKey]
        _tempData.remove(at: _tempData.index(forKey: fromKey)!)
        return value
    }
}
