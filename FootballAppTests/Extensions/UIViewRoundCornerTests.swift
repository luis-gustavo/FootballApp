//
//  UIViewRoundCornerTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import SnapshotTesting
import XCTest
@testable import FootballApp

final class UIViewRoundCornerTests: XCTestCase {

    func testRoundCorners() {
        // Given
        let view = UIView()

        // When
        view.roundCorners(radius: 20)

        // Then
        XCTAssertEqual(view.layer.masksToBounds, true)
        XCTAssertEqual(view.layer.cornerRadius, 20)
    }

    func testRoundCornersUI() {
        // Given
        let view = UIView(frame: .init(origin: .zero, size: .init(width: 40, height: 40)))
        view.backgroundColor = .white

        // When
        view.roundCorners(radius: 20)

        // Then
        assertSnapshot(matching: view, as: .image)
    }
}
