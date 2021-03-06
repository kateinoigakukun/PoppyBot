//
//  SlackTutorialPlugins.swift
//  PoppyBot
//
//  Created by SaitoYuta on 2017/09/02.
//
//

import SlackKit

struct PingPongPlugin: SlackPlugin {

    func respond(forMention message: String, with event: Event, bot: SlackKit, client: Client) throws {
        if message.uppercased() != "PING" { return }
        guard let channelId = event.channel?.id else { return }
        bot.webAPI?.sendMessage(channel: channelId, text: "PONG", asUser: true, success: nil, failure: nil)
    }
}

struct HelloPlugin {

    func response(for event: Event, bot: SlackKit) {
        Environment.current.logger.log(.info, message: "Start bot")
    }
}
