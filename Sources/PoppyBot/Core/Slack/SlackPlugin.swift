//
//  Plugin.swift
//  PoppyBot
//
//  Created by SaitoYuta on 2017/09/02.
//
//

import Foundation
import Rexy
import SlackKit

protocol SlackPlugin {

    func hear(for message: String, with event: Event, bot: SlackKit, client: Client) throws
    func respond(forMention mention: String, with event: Event, bot: SlackKit, client: Client) throws
}

extension SlackPlugin {

    func hear(for message: String, with event: Event, bot: SlackKit, client: Client) throws {}
    func respond(forMention message: String, with event: Event, bot: SlackKit, client: Client) throws {}

    func response(for message: String, with event: Event, bot: SlackKit, client: Client?) throws {
        guard let client = client else { return }
        if let text = mentionedText(with: message, user: client.authenticatedUser) {
            try respond(forMention: text, with: event, bot: bot, client: client)
        } else {
            try hear(for: message, with: event, bot: bot, client: client)
        }
    }

    private func mentionedText(with message: String, user: User?) -> String? {

        guard let groups = "<@(.+)> (.+)".regex?.groups(message),
            groups.count == 2, groups[0] == user?.id else { return nil }
        return groups[1]
    }
}
