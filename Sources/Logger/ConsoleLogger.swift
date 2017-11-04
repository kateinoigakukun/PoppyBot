//
//  ConsoleLogger.swift
//  Logger
//
//  Created by SaitoYuta on 2017/11/04.
//

import Foundation

public final class ConsoleLogger: Logger {

    private let enabled: [LogLevel]

    public init(enabled: [LogLevel] = LogLevel.asuha.all) {
        self.enabled = enabled
    }

    public func log(_ level: LogLevel, message: String) {
        guard enabled.contains(level) else { return }
        print("\(Date.init()) [\(level)] \(message)")
    }
}
