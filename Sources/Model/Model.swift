//
//  Model+Ex.swift
//  PoppyBotPackageDescription
//
//  Created by SaitoYuta on 2017/11/03.
//

import Fluent

public protocol Model: Entity, Codable {
    static var tableName: String { get }
}

extension Model {
    public static var tableName: String {
        return entity
    }

    public static func revert(_ database: Database) throws {
        try database.delete(tableName)
    }
}

extension Node: Codable {
    public init(from decoder: Decoder) throws {
        fatalError()
    }

    public func encode(to encoder: Encoder) throws {
        fatalError()
    }
}

extension Node.Number: Codable {
    public init(from decoder: Decoder) throws {
        fatalError()
    }

    public func encode(to encoder: Encoder) throws {
        fatalError()
    }
}

extension Schema.Creator {
    public func int(
        _ name: CodingKey,
        optional: Bool = false,
        unique: Bool = false,
        default: NodeRepresentable? = nil
        ) {
        int(name.stringValue, optional: optional, unique: unique, default: `default`)
    }

    public func string(
        _ name: CodingKey,
        length: Int? = nil,
        optional: Bool = false,
        unique: Bool = false,
        default: NodeRepresentable? = nil
        ) {
        string(name.stringValue, length: length, optional: optional, unique: unique, default: `default`)
    }

    public func double(
        _ name: CodingKey,
        optional: Bool = false,
        unique: Bool = false,
        default: NodeRepresentable? = nil
        ) {
        double(name.stringValue, optional: optional, unique: unique, default: `default`)
    }

    public func bool(
        _ name: CodingKey,
        optional: Bool = false,
        unique: Bool = false,
        default: NodeRepresentable? = nil
        ) {
        bool(name.stringValue, optional: optional, unique: unique, default: `default`)
    }

    public func data(
        _ name: CodingKey,
        optional: Bool = false,
        unique: Bool = false,
        default: NodeRepresentable? = nil
        ) {
        data(name.stringValue, optional: optional, unique: unique, default: `default`)
    }

    public func custom(
        _ name: CodingKey,
        type: String,
        optional: Bool = false,
        unique: Bool = false,
        default: NodeRepresentable? = nil
        ) {
        custom(name.stringValue, type: type, optional: optional, unique: unique, default: `default`)
    }
}
