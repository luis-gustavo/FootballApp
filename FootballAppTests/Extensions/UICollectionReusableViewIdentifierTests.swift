//
//  UICollectionReusableViewIdentifierTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import XCTest
@testable import FootballApp

final class UICollectionReusableViewIdentifierTests: XCTestCase {

    func testIdentifier() {
        // Given
        let expectedIdentifier = "MockedCollectionReusableView"

        // When

        // Then
        XCTAssertEqual(expectedIdentifier, MockedCollectionReusableView.identifier)
    }
}

private class MockedCollectionReusableView: UICollectionReusableView { }
