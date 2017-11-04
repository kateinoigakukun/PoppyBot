//
//  SportsMagicArticleItem.swift
//  poppy-bot-swiftPackageDescription
//
//  Created by SaitoYuta on 2017/11/03.
//

import Foundation
import Fluent
import Extension

public struct SportsMagicArticleItem: Model {

    enum CodingKeys: CodingKey {
        case id
        case title
        case url
        case date
    }

    public var id: Node?
    public let title: String
    public let url: URL
    public let date: Date
    public var exists: Bool = false

    fileprivate static let dateFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ"

    public init(title: String, url: URL, date: Date) {
        self.title = title
        self.url = url
        self.date = date
    }

    public init(node: Node, in context: Context) throws {
        id = try node.extract(CodingKeys.id.stringValue)
        title = try node.extract(CodingKeys.title.stringValue)
        url = try URL.init(string: node.extract(CodingKeys.url.stringValue))!
        let dateString: String = try node.extract(CodingKeys.date.stringValue)
        date = Date.asuha.date(string: dateString, format: SportsMagicArticleItem.dateFormat)!
    }

    public static func prepare(_ database: Database) throws {
        try database.create(tableName) { (schema) in
            schema.id()
            schema.string(CodingKeys.title, unique: true)
            schema.string(CodingKeys.url)
            schema.string(CodingKeys.date)
        }
    }

    public func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            CodingKeys.title.stringValue: title,
            CodingKeys.url.stringValue: url.absoluteString,
            CodingKeys.date.stringValue: date.asuha.string(format: SportsMagicArticleItem.dateFormat)
            ])
    }
}
