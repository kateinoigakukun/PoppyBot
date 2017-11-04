//
//  SportsMagicCrawler.swift
//  PoppyBot
//
//  Created by SaitoYuta on 2017/11/03.
//
//

import Foundation
import SlackKit
import FeedKit
import Model

final class SportsMagicCrawler: CronJobPlugin {
    var job: CronJob?

    var pattern: String { return "0 0 */1 * * *" }

    func execute(with bot: SlackKit) throws {
        let items = fetchNewItems()
        let attachments = items.map(makeAttachment(for: ))
        bot.webAPI?.sendMessage(channel: Environment.current.notificationChannel, text: "",
                                attachments: attachments, success: nil, failure: nil)
    }


    private let rssURL: URL = URL.init(string: "http://feedblog.ameba.jp/rss/ameblo/sports-magic/rss20.xml")!

    func fetchNewItems() -> [SportsMagicArticleItem] {

        guard let feed = FeedParser.init(URL: rssURL) else { return [] }
        let items: [SportsMagicArticleItem]? = {
            let result = feed.parse()
            switch result {
            case .rss(let rssFeed):
                return rssFeed.items?.flatMap {
                    guard let title = $0.title,
                    let urlString = $0.link,
                        let url = URL(string: urlString),
                        let date = $0.pubDate else { return nil }
                    var item = SportsMagicArticleItem.init(title: title, url: url, date: date)

                    do {
                        try item.save()
                    } catch let error {
                        Environment.current.logger.log(.verbose, message: error.localizedDescription)
                        return nil
                    }

                    return item
                }
            case .failure(let error):
                Environment.current.logger.log(.error, message: error.localizedDescription)
                return nil
            default: return nil
            }
        }()

        return items ?? []
    }

    private func makeAttachment(for item: SportsMagicArticleItem) -> Attachment {

        return Attachment.init(
            fallback: item.title,
            title: item.title, colorHex: "#3366ff",
            authorName: "スポーツマジック",
            authorLink: "https://ameblo.jp/sports-magic/",
            authorIcon: "https://stat.profile.ameba.jp/profile_images/20160119/16/24/Rg/j/o064006401453187789418.jpg",
            titleLink: item.url.absoluteString,
            footer: item.date.asuha.string(format: "YYYY-MM-dd"))
    }
}
