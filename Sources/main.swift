//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
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

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectMustache
import PerfectLogger
import PerfectRequestLogger
import Foundation
import StORM


struct HomeMustacheHandler: MustachePageHandler { // 所有目标句柄都必须从PageHandler对象继承
    // 以下句柄函数必须在程序中实现
    // 当句柄需要将参数值传入模板时会被系统调用。
    // - 参数 context 上下文环境：类型为MustacheWebEvaluationContext，为程序内读取HTTPRequest请求内容而保存的所有信息
    // - 参数 collector 结果搜集器：类型为MustacheEvaluationOutputCollector，用于调整模板输出。比如一个`defaultEncodingFunc`默认编码函数将被安装用于改变输出结果的编码方式。
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        var values = MustacheEvaluationContext.MapType()
        values["title"] = "swift用户"
        /// 等等等等
        contxt.extendValues(with: values)
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.status = .internalServerError
            response.appendBody(string: "\(error)")
            response.completed()
        }
    }
}

//router
var homeHandler:RequestHandler = { request, response in
    let webRoot = request.documentRoot
    mustacheRequest(request: request, response: response, handler: HomeMustacheHandler(), templatePath: webRoot + "/index.html")
}

var loginHandler:RequestHandler = { request, response in
    guard let userName = request.param(name: "userName") else {
        return
    }
    guard let password = request.param(name: "password") else {
        return
    }
    let resultDic:[String:Any] = ["responseBody":["userName":userName, "password":password, "result":"SUCCESS", "resultMsg":"login request success"]]
    do {
        let json = try resultDic.jsonEncodedString()
        response.setBody(string: json)
    } catch {
        var errMsg = "json convert error"
        response.setBody(string: errMsg)
    }
    response.completed()
}

var createHandler:RequestHandler = { request, response in
    guard let userName = request.param(name: "userName") else {
        response.completed()
        return
    }
    guard let password = request.param(name: "password") else {
        response.completed()
        return
    }
    let userToCreate = User()
    userToCreate.userName = userName
    userToCreate.password = password
    do {try userToCreate.save()} catch {fatalError("\(error)")}
}

var server = HTTPServer()
configureLog()
server.serverPort = 8181
server.serverAddress = "127.0.0.1"
var routes = Routes()
routes.add(method: .post, uri: "/login", handler: loginHandler)
routes.add(method: .get, uri: "/", handler: homeHandler)
server.addRoutes(routes)
server.setLogFilters()
testMysql()
do {
    try server.start()
} catch {
	fatalError("\(error)") // fatal error launching one of the servers
}

