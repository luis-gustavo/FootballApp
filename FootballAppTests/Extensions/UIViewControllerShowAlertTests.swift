//
//  UIViewControllerShowAlertTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import XCTest
@testable import FootballApp

final class UIViewControllerShowAlertTests: XCTestCase {

    func testShowAlertIsPresented() {
        // Given
        let window = UIWindow(frame: .init(origin: .zero, size: .init(width: 500, height: 500)))
        let viewController = UIViewController()
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        viewController.loadViewIfNeeded()

        // When
        viewController.showAlert(with: "", message: "", animated: false)

        // Then
        XCTAssertNotNil(viewController.presentedViewController)
        XCTAssertTrue(viewController.presentedViewController is UIAlertController)
    }
}
