//
//  Package.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 4/20/16.
//	Copyright (C) 2016 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import PackageDescription

let package = Package(
	name: "swift_server_demo",
	targets: [],
	dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),//http server
        .Package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", majorVersion: 2), //页面模版
        .Package(url: "https://github.com/PerfectlySoft/Perfect-RequestLogger.git", majorVersion: 1), //请求日志过滤器
        .Package(url: "https://github.com/PerfectlySoft/Perfect-Logger.git", majorVersion: 1), //日志写入文件
        .Package(url: "https://github.com/PerfectlySoft/Perfect-MySQL.git", majorVersion: 2),   //数据库
        .Package(url: "https://github.com/SwiftORM/MySQL-StORM", majorVersion:1)               //orm
    ]
)
