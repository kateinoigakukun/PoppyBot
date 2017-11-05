//
//  CronTriggerSlackPlugin.swift
//  PoppyBotPackage
//
//  Created by SaitoYuta on 2017/11/05.
//

import SlackKit
import Rexy

struct CronTriggerSlackPlugin: SlackPlugin {
    func respond(forMention message: String, with event: Event, bot: SlackKit, client: Client) throws {
        guard let channelId = event.channel?.id else { return }
        if message.lowercased() == "cron" {
            let message = """
\(app.cronJobPlugins.map { $0.jobName }.joined(separator: "\n"))
"""
            bot.webAPI?.sendMessage(channel: channelId, text: message, success: nil, failure: nil)
        } else if let regex = "cron run (.+)".regex, regex.isMatch(message) {
            let groups = regex.groups(message)
            guard let jobName = groups.first,
                let job = app.cronJobPlugins.first(where: { $0.jobName == jobName }) else { return }
            try job.execute(with: bot)
            bot.webAPI?.sendMessage(channel: channelId, text: "\(jobName) was done", success: nil, failure: nil)
        }
    }
}
