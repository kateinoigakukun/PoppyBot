//
//  WebRouters.swift
//  poppy-bot-swift
//
//  Created by SaitoYuta on 2017/09/03.
//
//

import SlackKit
import Swifter

struct HelloWorldRouter: WebRouterPlugin {
    
    var path: String { return "/" }

    func response(with request: HttpRequest, bot: SlackKit) -> HttpResponse {
        bot.webAPI?.sendMessage(channel: Environment.current.logChannel, text: "hello", success: nil, failure: nil)
        return .ok(.text("Hello World!"))
    }
}
