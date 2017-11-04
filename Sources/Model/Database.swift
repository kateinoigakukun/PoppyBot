//
//  Database.swift
//  Model
//
//  Created by SaitoYuta on 2017/09/03.
//
//

import Logger
import Fluent

public struct DatabaseCore {
    var database: Database
    let driver: Driver

    init(driver: Driver, models: [Model.Type], logger: Logger) {
        self.driver = driver
        self.database = .init(driver)

        do {
            try setup(models: models)
        } catch let error {
            logger.log(.verbose, message: error.localizedDescription)
        }
    }

    mutating func setup(models: [Model.Type]) throws {
        try models.forEach { model in
            defer { model.database = self.database }
            try model.prepare(self.database)
        }
    }
}

