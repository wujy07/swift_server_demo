//
//  Note.swift
//  swift_server_demo
//
//  Created by Junyan Wu on 17/1/19.
//
//

import MySQLStORM
import StORM
import Foundation

class Note: MySQLStORM {
    var id:Int = 0
    var title:String = ""
    var content:String = ""
    var userId:Int = 0
    var createTime:Date = Date();
    override func table() -> String {
        return "note"
    }
    override func to(_ this: StORMRow) {
        id = Int(this.data["id"] as! Int32)
        title = this.data["title"] as! String
        content = this.data["content"] as! String
        userId = Int(this.data["userId"] as! Int32)
        let timeString = this.data["createTime"] as! String
        if let temptime = DateFormatter().date(from: timeString) {
            createTime = temptime
        }
    }
}
