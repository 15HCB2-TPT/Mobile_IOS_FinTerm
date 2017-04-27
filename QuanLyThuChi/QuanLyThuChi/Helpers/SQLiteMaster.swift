//
//  SQLiteMaster.swift
//  BT_FileManager
//
//  Created by Hiroshi.Kazuo on 3/31/17.
//  Copyright © 2017 Hiroshi.Kazuo. All rights reserved.
//
//  Supports:
//    static func openDatabase(dbPath: String) -> SQLiteMaster?
//    func query(query: String) -> Bool
//    func select<T>(query: String, handler: (OpaquePointer!) -> T) -> [T]
//	  func count(tableName: String) -> Int32
//	  func isEmpty(tableName: String) -> Bool
//
//  Version 1.0
//  Change-log:
//      - 
//

import Foundation

class SQLiteMaster {
    var database: OpaquePointer
    fileprivate init(db: OpaquePointer){
        database = db
    }
    
    deinit {
        sqlite3_close(database)
    }
    
    static func setupDatabase(handler: () -> SQLiteMaster?) -> SQLiteMaster? {
        return handler()
    }
    
    static func openDatabase(dbPath: String) -> SQLiteMaster? {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let path = url.appendingPathComponent(dbPath).path
        print(path)
        var tmp: OpaquePointer?
        if sqlite3_open(path, &tmp) == SQLITE_OK {
            return SQLiteMaster(db: tmp!)
        } else {
            return nil
        }
    }
    
    func query(query: String) -> Bool {
        var statement: OpaquePointer?
        let r = sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK && sqlite3_step(statement) == SQLITE_DONE
        sqlite3_finalize(statement)
        return r
    }
    
    func select<T>(query: String, handler: (OpaquePointer!) -> T) -> [T] {
        var r = [T]()
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                r.append(handler(statement))
            }
        }
        sqlite3_finalize(statement)
        return r
    }
    
    func count(tableName: String) -> Int32 {
        var r: Int32 = 0
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(database, String(format: "select count(*) from %@", tableName), -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_ROW {
                r = sqlite3_column_int(statement, 0)
            }
        }
        sqlite3_finalize(statement)
        return r
    }
    
    func isEmpty(tableName: String) -> Bool {
        var r: Bool = false
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(database, String(format: "select * from %@ limit 1", tableName), -1, &statement, nil) == SQLITE_OK {
            r = sqlite3_step(statement) == SQLITE_ROW
        }
        sqlite3_finalize(statement)
        return !r
    }
}
