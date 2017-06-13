//
//  Translater.swift
//  QuanLyThuChi
//
//  Created by Hiroshi.Kazuo on 6/13/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import Foundation

class Translater {
    static var TranslaterIndex = -1
    static let Data: [String: [[String]]] = [
        "Hoàn tất": [["Done"]],
        "Huỷ": [["Cancel"]],
        
        "Năm": [["Year"]],
        "Tháng": [["Month"]],
        "Ngày": [["Date", "Day"]],
        "Ngôn ngữ": [["Language"]],
        "Tiếng Việt": [["Vietnamese"]],
        "Tiếng Anh": [["English"]]
    ]
    
    static func Trans(origin: String, index: Int = 0) -> String {
        if TranslaterIndex < 0 || Data[origin] == nil || TranslaterIndex >= (Data[origin]?.count)! {
            return origin
        }
        return Data[origin]![TranslaterIndex][index]
    }
}

extension String{
    var trans: String { return Translater.Trans(origin: self) }
    
    func trans(_ index: Int) -> String{
        return Translater.Trans(origin: self, index: index)
    }
}

class AppCurrency {
    static func CurrencyFormatter(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        let currency: Currency? = Database.isExistAndGet(predicater: NSPredicate(format: "id = %@", UserDefaults.standard.string(forKey: AppConfigs.CURRENCY_KEY)!))
        formatter.locale = Locale(identifier: (currency?.id)!)
        return formatter.string(from: NSNumber(value: value * (currency?.value)!))!
    }
    
    static func CurrencyFormatterBack(value: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        let currency: Currency? = Database.isExistAndGet(predicater: NSPredicate(format: "id = %@", UserDefaults.standard.string(forKey: AppConfigs.CURRENCY_KEY)!))
        formatter.locale = Locale(identifier: (currency?.id)!)
        return formatter.number(from: value) as! Double
    }
}

extension Double{
    var cur: String { return AppCurrency.CurrencyFormatter(value: self) }
}

extension String{
    var cur: Double { return AppCurrency.CurrencyFormatterBack(value: self) }
}
