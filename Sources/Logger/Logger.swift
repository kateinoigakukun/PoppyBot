//
//  Logger.swift
//  PoppyBotPackageDescription
//
//  Created by SaitoYuta on 2017/11/03.
//

import Extension

public protocol Logger {
    func log(_ level: LogLevel, message: String)
}

public enum LogLevel: EnumExtension {
    case verbose
    case debug
    case info
    case warning
    case error
    case fatal
}
