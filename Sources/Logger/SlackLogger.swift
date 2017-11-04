//
//  SlackLogger.swift
//  Logger
//
//  Created by SaitoYuta on 2017/11/04.
//

import SlackKit
import Foundation

public final class SlackLogger: Logger {

    let enabled: [LogLevel]
    private let bot: SlackKit
    private let channel: String

    public init(bot: SlackKit, logChannel: String, enabled: [LogLevel] = LogLevel.asuha.all) {
        self.bot = bot
        self.enabled = enabled
        self.channel = logChannel
    }

    public func log(_ level: LogLevel, message: String) {
        guard enabled.contains(level) else { return }
        bot.webAPI?.sendMessage(channel: channel, text: "\(Date.init()) [\(level)] \(message)", success: nil, failure: nil)
    }
}
