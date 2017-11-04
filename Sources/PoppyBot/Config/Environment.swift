//
//  Environment.swift
//  PoppyBot
//
//  Created by SaitoYuta on 2017/09/02.
//
//

import Logger
import Foundation

enum Environment {

    case development
    case production

    static var current: Environment {
        let environmentString: String = (try? getEnvironmentValue(for: "POPPY_ENV")) ?? ""
        switch environmentString {
        case "development": return .development
        case "production":  return .production
        default:            return .development
        }
    }

    static var slackToken: String {
        return try! getEnvironmentValue(for: "SLACK_TOKEN")
    }

    var notificationChannel: String {
        switch self {
        case .development: return "#bot"
        case .production:  return "#notification"
        }
    }

    var logChannel: String {
        switch self {
        case .development: return "#bot"
        case .production:  return "#log"
        }
    }

    var logger: Logger {
        switch self {
        case .development: return ConsoleLogger.init()
        case .production:  return SlackLogger.init(bot: app.bot, logChannel: logChannel)
        }
    }

    private static func getEnvironmentValue<T>(for key: String) throws -> T {
        guard let value = ProcessInfo.processInfo.environment[key] else {
            throw EnvironmentError.notFound(type: T.self, key: key)
        }
        guard let castedValue = value as? T else {
            throw EnvironmentError.faildToCast(type: T.self, key: key)
        }
        return castedValue
    }

    enum EnvironmentError<T>: Error, CustomDebugStringConvertible {
        case notFound(type: T.Type, key: String)
        case faildToCast(type: T.Type, key: String)

        var debugDescription: String {
            switch self {
            case .notFound(let type, let key):
                return "key not found (\(key): \(type))"
            case .faildToCast(let type, let key):
                return "faild to cast to \(type) (\(key))"

            }
        }
    }
}
