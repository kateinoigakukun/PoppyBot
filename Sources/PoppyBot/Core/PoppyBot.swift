
import SlackKit
import Foundation
import Model

class PoppyBot {

    private lazy var database: DatabaseCore = {
        return SQLiteDatabase.generate(with: self.models, logger: Environment.current.logger)
    }()

    // MARK: - Runner
    let bot: SlackKit = {
        let bot = SlackKit.init()
        bot.addRTMBotWithAPIToken(Environment.slackToken)
        bot.addWebAPIAccessWithToken(Environment.slackToken)
        return bot
    }()

    private lazy var cronScheduler: CronScheduler = {
        let scheduler = CronScheduler.init(bot: self.bot, jobPlugins: self.cronJobPlugins)
        return scheduler
    }()

    private lazy var webServer: WebServer = {
        return WebServer.init(bot: self.bot, routers: self.webRouterPlugins)
    }()


    // MARK: - Plugins
    private let slackPlugins: [SlackPlugin]
    private let cronJobPlugins: [CronJobPlugin]
    private let webRouterPlugins: [WebRouterPlugin]
    private let models: [Model.Type]

    init(slackPlugins: [SlackPlugin] = [],
         cronJobPlugins: [CronJobPlugin] = [],
         webPlugins: [WebRouterPlugin] = [],
         models: [Model.Type] = []) {

        self.slackPlugins = slackPlugins
        self.cronJobPlugins = cronJobPlugins
        self.webRouterPlugins = webPlugins
        self.models = models
    }


    // MARK: - Main
    func run() throws {
        register()
        _ = database
        try cronScheduler.run()
        try webServer.run()

    }

    private func register() {
        bot.notificationForEvent(.message) { event, client in
            guard let text = event.text else { return }
            do {
                try self.slackPlugins.forEach { plugin in
                    try plugin.response(for: text, with: event, bot: self.bot, client: client)
                }
            } catch let error {
                Environment.current.logger.log(.error, message: error.localizedDescription)
            }
        }

        bot.notificationForEvent(.hello) { event, client in
            HelloPlugin.init().response(for: event, bot: self.bot)
        }
    }
}
