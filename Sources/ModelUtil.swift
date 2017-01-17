//
//  ModelUtil.swift
//  swift_server_demo
//
//  Created by Junyan Wu on 17/1/19.
//
//

import MySQLStORM

func mysqlConfigure() {
    MySQLConnector.host = "127.0.0.1"
    MySQLConnector.username = "root"
    MySQLConnector.database = "swift_server_demo"
}

func testMysql() {
    mysqlConfigure()
    let user = User()
    user.userName = "test"
    user.password = "test"
    
    do {
        try user.setup()
        try user.save()
        let getedUser = User()
        try getedUser.get(1)
    } catch {fatalError("\(error)")}
}
