//
//  Plugins.swift
//  PoppyBot
//
//  Created by SaitoYuta on 2017/09/02.
//
//

import SlackKit

struct PingPongPlugin: SlackPlugin {

    func respond(for mention: String, with event: Event, bot: SlackKit, client: Client) throws {
        if mention.uppercased() != "PING" { return }
        guard let channelId = event.channel?.id else { return }
        bot.webAPI?.sendMessage(channel: channelId, text: "PONG", success: nil, failure: nil)
    }
}

struct HelloPlugin {

    func response(for event: Event, bot: SlackKit) {
        Environment.current.logger.log(.info, message: "Start bot")
    }
}
