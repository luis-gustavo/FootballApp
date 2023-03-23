//
//  UIStackViewAddArrangedSubviewsTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import XCTest
@testable import FootballApp

final class UIStackViewAddArrangedSubviewsTests: XCTestCase {

    func testAddArrangedSubviews() throws {
        // Given
        let stackView = UIStackView()
        let subview1 = UIView()
        let subview2 = UIView()

        // When
        stackView.addArrangedSubviews(
            subview1,
            subview2
        )

        // Then
        XCTAssertEqual(stackView.arrangedSubviews.count, 2)
        XCTAssertEqual(subview1.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertEqual(subview2.translatesAutoresizingMaskIntoConstraints, false)
    }

}
