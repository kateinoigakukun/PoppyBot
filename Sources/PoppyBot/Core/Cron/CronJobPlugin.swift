//
//  CronJobPlugin.swift
//  PoppyBotPackageDescription
//
//  Created by SaitoYuta on 2017/11/04.
//
//

import Cron
import SlackKit

protocol CronJob {}
extension Cron.CronJob: CronJob {}

protocol CronJobPlugin: class {
    var job: CronJob? { get set }
    var pattern: String { get }
    var jobName: String { get }
    func execute(with bot: SlackKit) throws
}

extension CronJobPlugin {

    var jobName: String { return String.init(describing: type(of: self)) }

    func start(with bot: SlackKit) throws {
        let execute = self.execute
        job = try Cron.CronJob.init(pattern: pattern) {
            do {
                Environment.current.logger.log(.verbose, message: "\(self.jobName) is executing")
                try execute(bot)
            } catch let error {
                Environment.current.logger.log(.error, message: error.localizedDescription)
            }
        }
    }
}
