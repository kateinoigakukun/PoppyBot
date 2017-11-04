//
//  main.swift
//  PoppyBot
//
//  Created by SaitoYuta on 2017/09/02.
//
//

import Model
import Foundation

let app = PoppyBot.init(
    slackPlugins: [PingPongPlugin.init()],
    cronJobPlugins: [WasedaNewsCrawler.init(), SportsMagicCrawler.init()],
    webPlugins: [HelloWorldRouter.init()],
    models: [WasedaNewsItem.self, SportsMagicArticleItem.self])
try app.run()
RunLoop.main.run()
