//
//  SeedData.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 6/5/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class SeedData {

    static func seedData(){
        clearData()
        seedType()
        seedBagMoney()
    }
    
    static func clearData() {
        Database.clear(entityName: "Money")
        Database.clear(entityName: "BagMoney")
        Database.clear(entityName: "BagMoney_Type")
        Database.clear(entityName: "Common")
        Database.clear(entityName: "Category")
        Database.clear(entityName: "Type")
        Database.save()
    }
    
    private static func seedType() {
        let tempthu:Type = Database.create()
        tempthu.name = "Thu"
        Database.save()
        let tempchi:Type = Database.create()
        tempchi.name = "Chi"
        Database.save()
        
        let temp1:Category = Database.create()
        temp1.name = "Lương"
        temp1.category_type = tempthu
        Database.save()
        let temp2:Category = Database.create()
        temp2.name = "Thưởng"
        temp2.category_type = tempthu
        Database.save()
        
        let temp3:Category = Database.create()
        temp3.name = "Ăn uống"
        temp3.category_type = tempchi
        Database.save()
        let temp4:Category = Database.create()
        temp4.name = "Đi lại"
        temp4.category_type = tempchi
        Database.save()
    }
    
    private static func seedBagMoney() {
        let temp1:BagMoney_Type = Database.create()
        temp1.name = "Tiền mặt"
        Database.save()
        let temp2:BagMoney_Type = Database.create()
        temp2.name = "Tài khoản ngân hàng"
        Database.save()
        
        let temp3:BagMoney = Database.create()
        temp3.name = "Thẻ ATM"
        temp3.money = 500000
        temp3.bagmoney_type = temp2
        Database.save()
        let temp4:BagMoney = Database.create()
        temp4.name = "Ví"
        temp4.money = 1000000
        temp4.bagmoney_type = temp1
        Database.save()
    }
    
//    private static func seedFoodType(){
//        //if Database.isEmpty(entityName: "FoodType") {
//        let data = ["Thức uống", "Lẩu", "Đồ nướng", "Hải sản", "Cơm"]
//        for each in data {
//            let d: FoodType = Database.create()
//            d.nametype = each
//        }
//        Database.save()
//        //}
//    }
//    
//    private static func seedCurrency(){
//        //if Database.isEmpty(entityName: "Currency") {
//        let data = [("vnd", 22000.0, "vi_VN"), ("$", 1.0, "en_US")]
//        for each in data {
//            let d: Currency = Database.create()
//            d.name = each.0
//            d.value = each.1
//            d.countryId = each.2
//        }
//        Database.save()
//        //}
//    }
//    
//    private static func seedRegion(){
//        //if Database.isEmpty(entityName: "Region") {
//        let data = [("Trong nhà", ""), ("Ngoài trời", ""), ("Sân vườn", "")]
//        for each in data {
//            let d: Region = Database.create()
//            d.name = each.0
//            d.des = each.1
//            d.is_deleted = false
//            d.image = UIImage(named: "Partly Cloudy Day Filled-50-SIlver")?.pngRepresentationData
//        }
//        Database.save()
//        //}
//    }
//    
//    private static func seedTable(){
//        //if Database.isEmpty(entityName: "Table") {
//        var id =  1
//        for reg in Database.select(entityName: "Region") as! [Region] {
//            let data = [("\(id)A1", Int32.random(lower: 2, upper: 4)), ("\(id)A2", Int32.random(lower: 2, upper: 4)), ("\(id)A3", Int32.random(lower: 2, upper: 4)), ("\(id)B1", Int32.random(lower: 4, upper: 12)), ("\(id)B2", Int32.random(lower: 4, upper: 12))]
//            for each in data {
//                let d: Table = Database.create()
//                d.name = each.0
//                d.number = each.1
//                d.table_region = reg
//                d.is_empty = true
//                d.is_deleted = false
//                d.img = UIImage(named: "Table Filled-50-Silver")?.pngRepresentationData
//            }
//            id += 1
//        }
//        Database.save()
//        //}
//    }
//    
//    private static func seedFood(){
//        //if Database.isEmpty(entityName: "Food") {
//        let data = [("Thức uống", "Coca"), ("Thức uống", "Pepsi"), ("Thức uống", "7 Up"), ("Thức uống", "Bia Tiger"), ("Thức uống", "Bia 333"), ("Lẩu", "Lẩu Thái"), ("Lẩu", "Lẩu chua cay"), ("Lẩu", "Lẩu hải sản"), ("Hải sản", "Mực xào"), ("Hải sản", "Nghêu nấu bia"), ("Hải sản", "Ốc len"), ("Cơm", "Cơm hải sản"), ("Cơm", "Cơm thập cẩm"), ("Cơm", "Cơm chiên")]
//        for each in data {
//            let ft: FoodType? = Database.isExistAndGet(predicater: NSPredicate(format: "nametype == %@", each.0))
//            if ft != nil {
//                let d: Food = Database.create()
//                d.name = each.1
//                d.is_use = true
//                d.food_type = ft
//                d.image = UIImage(named: "Kebab Filled-50-Silver")?.pngRepresentationData
//                d.money = Double(Int64.random(lower: 1, upper: 1000)) / 100
//            }
//        }
//        Database.save()
//        //}
//    }
//    
//    private static func seedOrder(){
//        //if Database.isEmpty(entityName: "Order") {
//        let tables: [Table] = Database.select()
//        let data = ["14-4", "14-4", "14-4", "14-4", "14-4", "15-4", "15-4", "15-4", "16-4", "16-4", "16-4", "16-4", "16-4", "17-4", "18-4", "18-4", "18-4", "18-4", "18-4", "19-4", "19-4", "19-4", "19-4", "19-4", "19-4", "19-4", "19-4", "19-4", "20-4", "20-4", "20-4", "20-4"]
//        for each in data {
//            let d: Order = Database.create()
//            d.date = "\(each)-2017"
//            d.order_table = tables[Int.random(lower: 0, upper: tables.count)]
//            d.totalmoney = 0
//            d.is_paid = true
//        }
//        Database.save()
//        //}
//    }
//    
//    private static func seedDetailsOrder(){
//        //if Database.isEmpty(entityName: "DetailsOrder") {
//        let orders: [Order] = Database.select()
//        let foods: [Food] = Database.select()
//        for _ in 10...Int.random(lower: 20, upper: 100) {
//            let d: DetailsOrder = Database.create()
//            d.detailsorder_order = orders[Int.random(lower: 0, upper: orders.count)]
//            d.detailsorder_food = foods[Int.random(lower: 0, upper: foods.count)]
//            d.number = Double(Int64.random(lower: 1, upper: 5))
//            d.money = (d.detailsorder_food?.money)!
//            d.detailsorder_order?.totalmoney += d.money * Double(d.number)
//        }
//        Database.save()
//        //}
    
}
