//
//  TeamDetailViewControllerTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import SnapshotTesting
import XCTest
@testable import FootballApp

final class TeamDetailViewControllerTests: XCTestCase {

    private var sut: TeamDetailViewController!

    override func setUp() {
        super.setUp()
        sut = TeamDetailViewController(viewModel: .init(
            title: "Team Red Dragons",
            logoImageUrl: Bundle(for: ImageLoaderTests.self).url(forResource: "ball", withExtension: "png"))
        )
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testUILightMode() throws {
        // Given
        let navigationController = UINavigationController(rootViewController: sut)
        navigationController.overrideUserInterfaceStyle = .light
        sut.overrideUserInterfaceStyle = .light

        // When

        // Then
        assertSnapshot(matching: navigationController, as: .image(on: .iPhone12))
    }

    func testUIDarkMode() throws {
        // Given
        let navigationController = UINavigationController(rootViewController: sut)
        navigationController.overrideUserInterfaceStyle = .dark
        sut.overrideUserInterfaceStyle = .dark

        // When

        // Then
        assertSnapshot(matching: navigationController, as: .image(on: .iPhone12))
    }

}
