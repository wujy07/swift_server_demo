//
//  log.swift
//  swift_server_demo
//
//  Created by Junyan Wu on 17/1/19.
//
//

import PerfectHTTPServer
import PerfectLogger
import PerfectRequestLogger
import PerfectLib
import Foundation

func configureLog() {
    let logPath = "./Files/Log"
    let dir = Dir(logPath)
    if (!dir.exists) {
        do {
            try dir.create()
        } catch {
            NSLog("创建日志记录目录失败\(error)")
            return
        }
    }
    LogFile.location = "\(logPath)/server.log"
    RequestLogFile.location = "\(logPath)/request.log"
}

extension HTTPServer {
    func setLogFilters() {
        self.setRequestFilters([(RequestLogger(), .high)])
        self.setResponseFilters([(RequestLogger(), .low)])
    }
}
