//
//  Translater.swift
//  QuanLyThuChi
//
//  Created by Hiroshi.Kazuo on 6/13/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class Translater {
    private static var TranslaterIndex = -1
    private static let Data: [String: [[String]]] = [
        
        //Common
        "Hoàn tất": [["Done"]],
        "Hủy": [["Cancel"]],
        "Xong": [["Done"]],
        "Thêm": [["Add"]],
        "Lỗi": [["Error"]],
        "Thành công": [["Success"]],
        "<Trở lại": [["<Back"]],
        "Cảnh báo": [["Warning"]],
        "Thông báo": [["Notice"]],
        "Thêm thành công!" : [["Add success!"]],
        "Năm": [["Year"]],
        "Tháng": [["Month"]],
        "Ngày": [["Date", "Day"]],
        
        //Settings
        "Cài đặt": [["Setting"]],
        "Ngôn ngữ": [["Language"]],
        "Tiếng Việt": [["Vietnamese"]],
        "Tiếng Anh": [["English"]],
        
        //Money
        "Ghi chép": [["Add record"]],
        
        //Bag Money
        "Tài khoản":[["Account"]],
        "Số tài khoản âm":[["Number Minus Account"]],
        "Tổng số tài khoản":[["Total Number Account"]],
        "Tổng số tiền":[["Total Money"]],
        "Thông tin cá nhân":[["My Profile"]],
        "Thêm tài khoản":[["New Account"]],
        "Số tiền":[["Money"]],
        "Loại tk":[["Type"]],
        "Tên tk":[["Name"]],
        "Thêm tài khoản mới":[["Add Account"]],
        "Danh sách tài khoản của tôi":[["All my Accounts"]],
        "Tên tài khoản":[["Account's name"]],
        "Loại tài khoản":[["Account's type"]],
        "Thêm loại tài khoản": [["Add Type Account"]],
        "Tên loại tài khoản": [["Nametype"]],
        "Đã thêm túi tiền mới thành công!": [["Add new Account completed"]],
        "Loại túi đã tồn tại":[["Account is existed!"]],
        "Hãy nhập tên túi tiền": [["Please insert name of Account"]],
        "Số tiền có sẵn trong túi không đúng":[["Money incorrect!"]],
        "Danh sách túi tiền": [["Accounts list"]],
        "Thu chi sẽ bị xóa theo túi tiền, bạn có muốn tiếp tục":[["This behavior will remove all record of this Account. Are you sure?"]],
        
        //Custom
        "Danh mục thu chi": [["Categories list"]],
        "Danh sách thiết lập nhanh":[["Availabilities list"]],
        "Thiết lập": [["Availability"]],
        "Thêm mới thiết lập nhanh": [["Add new Availability"]],
        "Loại phí": [["Type"]],
        "Danh mục": [["Category"]],
        "Túi hay dùng": [["Account"]],
        "Băt đầu từ": [["Begin"]],
        "Lặp":[["Loop"]],
        "Thu/Chi": [["Income/Expense"]],
        "Ngày chạy": [["test"]],
        "Hôm nay": [["Today"]],
        "Bạn chưa có túi tiền nào, hãy thêm túi tiền mới trước!":[["Please insert new Account before use this behavior!"]],
        "Danh mục chưa được chọn. Hãy chọn lại.": [["Category not selected. Please choose one."]],
        "Tài khoản không hợp lệ.":[["Account is not exists!"]],
        "Đặt tên thiết lập nhanh.": [["Set Avaibility's name"]],
        "Tên thiết lập": [["Name"]],
        "Tên thiết lập nhanh không được để trống!": [["Name can't empty!"]],
        "Tên thiết lập đã tồn tại, hãy đặt tên khác.": [["This name existed, please try another name."]],

        //Report
        "Thống kê": [["Report"]],
        "Từ ngày":[["From"]],
        "Đến ngày":[["To"]],
        "Theo thời gian": [["In time"]],
        "Thống kê theo":[["Report for"]],
        "Thu":[["Income"]],
        "Chi": [["Expense"]],
        "Chuyển khoản": [["Transfer"]],
        "Tùy chọn":[["Option"]]
        
        
    ]
    
    static func Trans(origin: String, index: Int = 0) -> String {
        if TranslaterIndex < 0 || Data[origin] == nil || TranslaterIndex >= (Data[origin]?.count)! {
            return origin
        }
        return Data[origin]![TranslaterIndex][index]
    }
    
    static var TranslateForms = [UIViewController]()
    static func AddForm(form: UIViewController){
        TranslateForms.append(form)
    }
    
    static func ChangeTransIndex(_ newIndex: Int){
        TranslaterIndex = newIndex
        for item in TranslateForms{
            item.trans()
        }
    }
    
}

extension String{
    var trans: String { return Translater.Trans(origin: self) }
    
    func trans(_ index: Int) -> String{
        return Translater.Trans(origin: self, index: index)
    }
}

extension UIViewController {
    open func transReload(){}
    
    func trans(){
        do{
            try transReload()
        }catch{
            
        }
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
