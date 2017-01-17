//
//  User.swift
//  swift_server_demo
//
//  Created by Junyan Wu on 17/1/19.
//
//


import MySQLStORM
import Foundation
import StORM

class User: MySQLStORM {
    var id:Int = 0
    var userName:String = ""
    var password:String = ""
    var registerTime:Date = Date()
    
    override func table() -> String {
        return "user"
    }
    
    override func to(_ this: StORMRow) {
        id = Int(this.data["id"] as! Int32)
        userName = this.data["userName"] as! String
        password = this.data["password"] as! String
        let timeString = this.data["registerTime"] as! String
        if let temptime = DateFormatter().date(from: timeString) {
            registerTime = temptime
        }
    }
    
//    func rows() -> [User] {
//        var rows = [User]()
//        for i in 0..<self.results.rows.count {
//            let row = User()
//            row.to(self.results.rows[i])
//            rows.append(row)
//        }
//        return rows
//    }
}
