//
//  UIViewAddSubviewsTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 21/03/23.
//

import UIKit
import XCTest
@testable import FootballApp

final class UIViewAddSubviewsTests: XCTestCase {

    func testAddSubviews() throws {
        // Given
        let superView = UIView()
        let subview1 = UIView()
        let subview2 = UIView()

        // When
        superView.addSubviews(
            subview1,
            subview2
        )

        // Then
        XCTAssertEqual(subview1.superview, superView)
        XCTAssertEqual(subview2.superview, superView)
        XCTAssertEqual(subview1.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertEqual(subview2.translatesAutoresizingMaskIntoConstraints, false)
    }
}
