//
//  TeamEndpointTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import XCTest
@testable import FootballApp

final class TeamEndpointTests: XCTestCase {

    func testTeamsEndpointUrl() throws {
        // Given
        let endpoint = TeamEndpoint.teams

        // When

        // Then
        XCTAssertEqual(endpoint.url?.absoluteString, "https://jmde6xvjr4.execute-api.us-east-1.amazonaws.com/teams")
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertTrue(endpoint.queryParameters.isEmpty)
        XCTAssertTrue(endpoint.headers.isEmpty)
        XCTAssertNil(endpoint.body)
    }
}
