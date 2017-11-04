//
//  WebRouter.swift
//  PoppyBot
//
//  Created by SaitoYuta on 2017/09/02.
//
//

import SlackKit
import Swifter

class WebServer {
    private let server: HttpServer = .init()
    private let bot: SlackKit
    
    private let routers: [WebRouterPlugin]

    init(bot: SlackKit, routers: [WebRouterPlugin]) {
        self.bot = bot
        self.routers = routers
    }

    func run() throws {
        for router in routers {
            server[router.path] = { [unowned self] request in
                router.response(with: request, bot: self.bot)
            }
        }

        try server.start()
    }
}
