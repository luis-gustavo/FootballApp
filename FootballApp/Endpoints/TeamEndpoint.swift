//
//  TeamEndpoint.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Foundation
import Networking

enum TeamEndpoint: EndPoint {

    case teams

    var url: URL? {
        return URL(string: "https://jmde6xvjr4.execute-api.us-east-1.amazonaws.com/teams")
    }

    var method: HTTPMethod { .get }

    var headers: [String: String] { [:] }

    var queryParameters: [String: Any] { [:] }

    var body: Data? { nil }
}
