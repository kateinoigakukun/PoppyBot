//
//  SQLiteDatabase.swift
//  Model
//
//  Created by SaitoYuta on 2017/11/04.
//

import FluentSQLite
import Foundation
import Logger

public struct SQLiteDatabase {

    public static func generate(with path: String, models: [Model.Type], logger: Logger) throws -> DatabaseCore {
        let driver = try SQLiteDriver.init(path: FileManager.default.asuha.generatePath("./data/database.sqlite"))
        let database = DatabaseCore.init(driver: driver, models: models, logger: logger)
        return database
    }
}
