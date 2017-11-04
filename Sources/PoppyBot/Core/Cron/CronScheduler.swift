//
//  CronScheduler.swift
//  PoppyBot
//
//  Created by SaitoYuta on 2017/09/02.
//
//

import Cron
import SlackKit

struct CronScheduler {

    private let bot: SlackKit
    private var jobPlugins: [CronJobPlugin]

    init(bot: SlackKit, jobPlugins: [CronJobPlugin]) {
        self.bot = bot
        self.jobPlugins = jobPlugins
    }

    func run() throws {
        try jobPlugins.forEach { plugin in
            try plugin.start(with: self.bot)
        }
    }
}


