//
//  WebRouterPlugin.swift
//  PoppyBotPackageDescription
//
//  Created by SaitoYuta on 2017/11/04.
//
//

import Swifter
import SlackKit

protocol WebRouterPlugin {

    var path: String { get }

    func response(with request: HttpRequest, bot: SlackKit) -> HttpResponse
}
