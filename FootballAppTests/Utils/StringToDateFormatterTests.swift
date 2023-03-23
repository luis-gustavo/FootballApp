//
//  StringToDateFormatterTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import XCTest
@testable import FootballApp

final class StringToDateFormatterTests: XCTestCase {

    func testTestDateTimeFormatter() {
        // Given
        let dateString = "2022-04-23T18:00:00.000Z"
        let expectedOutput = "04/23/2022 06:00 PM"

        // When
        let dateFormatted = StringToDateFormatter.dateTimeFormatted(from: dateString)

        // Then
        XCTAssertNotNil(dateFormatted)
        XCTAssertEqual(dateFormatted, expectedOutput)
    }
}
