//
//  SQLiteDatabase.swift
//  PoppyBotPackageDescription
//
//  Created by SaitoYuta on 2017/11/04.
//

import FluentSQLite
import Logger
import Foundation

public struct SQLiteDatabase {

    public static func generate(with models: [Model.Type], logger: Logger) -> DatabaseCore {
        let driver = try! SQLiteDriver.init(path: FileManager.default.asuha.generatePath("./data/database.sqlite"))
        let database = DatabaseCore.init(driver: driver, models: models, logger: logger)
        return database
    }
}
