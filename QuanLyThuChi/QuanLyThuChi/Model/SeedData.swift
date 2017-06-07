//
//  SeedData.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 6/5/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class SeedData {
    static let SEED_START_DATE = "2017-5-1"
    static let TYPE_A = "Thu"
    static let TYPE_B = "Chi"
    
    static func seedData(){
        clearData()
        seed_BagMoney_BMType()
        seed_Type_Category()
        seed_Common()
        seed_Money()
    }
    
    static func clearData(){
        Database.clear(entityName: "Money")
        Database.clear(entityName: "Common")
        Database.clear(entityName: "Category")
        Database.clear(entityName: "Type")
        Database.clear(entityName: "BagMoney")
        Database.clear(entityName: "BagMoney_Type")
        Database.save()
    }
    
    private static func seed_BagMoney_BMType(){
        let dateF = DateFormatter()
        dateF.dateFormat = "yyyy-MM-dd"
        
        let a = ["Ngân hàng", "Ví"]
        let b = [["Aribank", "Vietinbank", "Vietcombank", "Sacombank", "Techcombank", "DongABank"], ["Ví cá nhân"]]
        var c = 0
        
        for d in a {
            let e: BagMoney_Type = Database.create()
            e.name = d
            for f in b[c] {
                let g: BagMoney = Database.create()
                g.bagmoney_type = e
                g.name = f
                g.money = 0
                g.date = dateF.date(from: SEED_START_DATE) as! NSDate
                Database.save()
            }
            c += 1
            Database.save()
        }
    }
    
    private static func seed_Type_Category(){
        let a = [TYPE_A, TYPE_B]
        let b = [["Thu trong ngày", "Thu trong tháng", "Thu của năm", "Khoản thu đặc biệt", "Khoản thu bất chính"], ["Chi trong ngày", "Chi trong tháng", "Chi của năm", "Khoản chi đặc biệt", "Khoản chi bất chính"]]
        var c = 0
        
        for d in a {
            let e: Type = Database.create()
            e.name = d
            for f in b[c] {
                let g: Category = Database.create()
                g.category_type = e
                g.name = f
                Database.save()
            }
            c += 1
            Database.save()
        }
    }
    
    private static func seed_Common(){
        let dateF = DateFormatter()
        dateF.dateFormat = "yyyy-MM-dd"
        
        let a = [
                    (   "Ví cá nhân",          
                        "Chi trong ngày",       
                        true, false, false, 1,              
                        2000.0,     
                        "Gửi xe"),
                        
                    (   "Ví cá nhân",          
                        "Chi trong ngày",       
                        true, false, false, 1,
                        100000.0,   
                        "Đi chợ"),
                        
                    (   "Ví cá nhân",          
                        "Khoản chi bất chính",  
                        false, false, false, 0,              
                        500000.0,   
                        "Chăm gái"),
                        
                    (   "Ví cá nhân",          
                        "Chi trong tháng",      
                        false, true, false, 1,
                        2000000.0,  
                        "Chơi hụi"),
                        
                    (   "Aribank",
                        "Thu trong tháng",      
                        false, true, false, 1,
                        10000000.0, 
                        "Lãnh lương"),
                    
                    (   "Aribank",
                        "Chi trong tháng",
                        false, true, false, 1,
                        10000000.0,
                        "Rút tiền lương tháng"),
                    
                    (   "Ví cá nhân",
                        "Thu trong tháng",
                        false, true, false, 1,
                        10000000.0,
                        "Rút tiền lương"),
                    
                    (   "Ví cá nhân",
                        "Chi trong tháng",
                        false, true, false, 1,
                        6000000.0,
                        "Đưa vợ")
                ]
        
        for b in a {
            let d: BagMoney? = Database.isExistAndGet(predicater: NSPredicate(format: "name = %@", b.0))
            let e: Category? = Database.isExistAndGet(predicater: NSPredicate(format: "name = %@", b.1))
            if d != nil && e != nil {
                let c: Common = Database.create()
                c.bagmoney = d!
                c.category = e!
                c.loopday = b.2
                c.loopmonth = b.3
                c.loopyear = b.4
                c.looptime = Int32(b.5)
                c.money = b.6
                c.name = b.7
                c.lastadd = dateF.date(from: SEED_START_DATE) as! NSDate
                Database.save()
            }
        }
    }
    
    private static func seed_Money(){
        let dateF = DateFormatter()
        dateF.dateFormat = "yyyy-MM-dd"
        
        //create some trades
        let a = [
                    (   "Ví cá nhân",
                        "Chi trong ngày",
                        200000.0,
                        "Cho Tú mượn tiền mua bikini",
                        false, false,
                        "2017-4-25"),
                        
                    (   "Ví cá nhân",
                        "Thu trong ngày",
                        500000.0,
                        "Lượm được của rơi tạm thời đút túi",
                        false, false,
                        "2017-5-16"),
                        
                    (   "Ví cá nhân",
                        "Chi trong ngày",
                        110000.0,
                        "Bể bánh xe",
                        false, false,
                        "2017-5-20"),
                        
                    //transfer
                    (   "Ví cá nhân",
                        "",
                        2000000.0,
                        "Gửi tiết kiệm",
                        false, true,
                        "2017-6-2"),
                        
                    (   "Aribank",
                        "",
                        2000000.0,
                        "Gửi tiết kiệm",
                        true, false,
                        "2017-6-2")
                    //=====
                ]
        
        var old: Money!
        for b in a {
            let d: BagMoney? = Database.isExistAndGet(predicater: NSPredicate(format: "name = %@", b.0))
            let e: Category? = Database.isExistAndGet(predicater: NSPredicate(format: "name = %@", b.1))
            if d != nil && (e != nil || b.4 || b.5) {
                let c: Money = Database.create()
                c.date = dateF.date(from: b.6) as! NSDate
                c.money_bagmoney = d
                c.money_category = e
                if e?.category_type?.name == TYPE_A {
                    d?.money += b.2
                } else if e?.category_type?.name == TYPE_B {
                    d?.money -= b.2
                }
                c.money = b.2
                c.reason = b.3
                if b.4 {
                    c.transfer = old
                    old.transfer = c
                }else{
                    c.transfer = nil
                }
                Database.save()
                old = c
            }
        }
        
        //create trades from commons
        let bags: [BagMoney] = Database.select()
        let now = NSDate()
        for eachBag in bags {
            let commons: [Common] = Database.select(predicater: NSPredicate(format: "bagmoney.name = %@", eachBag.name!))
            for eachCom in commons {
                if eachCom.loopday || eachCom.loopmonth || eachCom.loopyear {
                    var com: Calendar.Component!
                    if eachCom.loopday {
                        com = .day
                    } else if eachCom.loopmonth {
                        com = .month
                    } else if eachCom.loopyear {
                        com = .year
                    }
                    while Int32(NSDate.calicuateDaysBetweenTwoDates(start: eachCom.lastadd!, end: now, com: com)) >= eachCom.looptime {
                        let trade: Money = Database.create()
                        trade.date = eachCom.lastadd
                        trade.money = eachCom.money
                        trade.transfer = nil
                        trade.reason = eachCom.name
                        trade.money_bagmoney = eachCom.bagmoney
                        trade.money_category = eachCom.category
                        if eachCom.category?.category_type?.name == TYPE_A {
                            eachCom.bagmoney?.money += eachCom.money
                        } else if eachCom.category?.category_type?.name == TYPE_B {
                            eachCom.bagmoney?.money -= eachCom.money
                        }
                        eachCom.lastadd = eachCom.lastadd?.add(value: Int(eachCom.looptime), com: com)
                        Database.save()
                    }
                }
            }
        }
    }
    
    static func seedCommonFromLastOpen(){
        //create trades from commons
        let bags: [BagMoney] = Database.select()
        let now = NSDate()
        for eachBag in bags {
            let commons: [Common] = Database.select(predicater: NSPredicate(format: "bagmoney.name = %@", eachBag.name!))
            for eachCom in commons {
                if eachCom.loopday || eachCom.loopmonth || eachCom.loopyear {
                    var com: Calendar.Component!
                    if eachCom.loopday {
                        com = .day
                    } else if eachCom.loopmonth {
                        com = .month
                    } else if eachCom.loopyear {
                        com = .year
                    }
                    while Int32(NSDate.calicuateDaysBetweenTwoDates(start: eachCom.lastadd!, end: now, com: com)) >= eachCom.looptime {
                        let trade: Money = Database.create()
                        trade.date = eachCom.lastadd
                        trade.money = eachCom.money
                        trade.transfer = nil
                        trade.reason = eachCom.name
                        trade.money_bagmoney = eachCom.bagmoney
                        trade.money_category = eachCom.category
                        if eachCom.category?.category_type?.name == TYPE_A {
                            eachCom.bagmoney?.money += eachCom.money
                        } else if eachCom.category?.category_type?.name == TYPE_B {
                            eachCom.bagmoney?.money -= eachCom.money
                        }
                        eachCom.lastadd = eachCom.lastadd?.add(value: Int(eachCom.looptime), com: com)
                        Database.save()
                    }
                }
            }
        }
    }
}
