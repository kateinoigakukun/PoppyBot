//
//  WasedaNewsCrawler.swift
//  PoppyBot
//
//  Created by SaitoYuta on 2017/09/03.
//
//

import Foundation
import SlackKit
import Kanna
import Model

class WasedaNewsCrawler: CronJobPlugin {
    var job: CronJob?
    var pattern: String { return "0 0 */1 * * *" }

    func execute(with bot: SlackKit) throws {
        let items = try fetchNewItems()
        let attachments = items.map(makeAttachment(for: ))
        bot.webAPI?.sendMessage(channel: "#bot", text: "", asUser: true, attachments: attachments, success: nil, failure: nil)
    }


    private let baseURL: URL = URL(string: "https://www.waseda.jp")!
    private var url: URL { return baseURL.appendingPathComponent("/school/shs/news/") }
    private let itemXPath: String = "//*[@id=\"anc_pagetop\"]/div[5]/div/div[3]/div/div[2]/div"

    func fetchNewItems() throws -> [WasedaNewsItem] {
        let html = try HTML(url: url, encoding: .utf8)
        let items: [WasedaNewsItem] = try html.xpath(itemXPath).flatMap { node -> WasedaNewsItem? in

            guard let htmlString = node.toHTML else { return nil }
            let nodeHTML = try HTML(html: htmlString, encoding: .utf8)
            guard
                let title = nodeHTML.at_xpath("//h4[@class=\"slab-heading\"]")?.text,
                let urlString = nodeHTML.at_xpath("//a")?["href"],
                let url = URL(string: urlString, relativeTo: baseURL),
                let thumbnailURLString = nodeHTML.at_xpath("//img")?["src"],
                let thumbnailURL = URL(string: thumbnailURLString),
                let dateString = nodeHTML.at_xpath("//time")?.text?.replacingOccurrences(of: " ", with: ""),
                let date = Date.asuha.date(string: dateString, format: "EEE, dd MMM yyyy")
                else { return nil }

            var item = WasedaNewsItem.init(title: title, url: url, thumbnailURL: thumbnailURL, date: date)
            do {
                try item.save()
            } catch let error {
                Environment.current.logger.log(.verbose, message: error.localizedDescription)
                return nil
            }
            return item
        }

        return items
    }

    private func makeAttachment(for item: WasedaNewsItem) -> Attachment {

        return Attachment.init(
            fallback: item.title,
            title: item.title, colorHex: "#9b042c",
            authorName: "Waseda",
            authorLink: "https://www.waseda.jp/school/shs",
            authorIcon: "https://www.waseda.jp/school/shs/assets/themes/waseda-template-engine-alt/img/logo-header-sm.png",
            titleLink: item.url.absoluteString,
            thumbURL: item.thumbnailURL.absoluteString,
            footer: item.date.asuha.string(format: "YYYY-MM-dd"))
    }
}
