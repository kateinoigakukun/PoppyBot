//
//  Database.swift
//  PoppyBot
//
//  Created by SaitoYuta on 2017/09/03.
//
//


import Extension
import FluentSQLite
import Foundation
import Fluent
import Logger

public struct DatabaseCore {
    var database: Database
    let driver: Driver
    let logger: Logger

    init(driver: Driver, models: [Model.Type], logger: Logger) {
        self.driver = driver
        self.database = .init(driver)
        self.logger = logger

        setup(models: models)
    }

    mutating func setup(models: [Model.Type]) {
        models.forEach {
            do {
                try $0.prepare(self.database)
            } catch let error {
                logger.log(.verbose, message: error.localizedDescription)
            }
            $0.database = self.database
        }
    }
}

