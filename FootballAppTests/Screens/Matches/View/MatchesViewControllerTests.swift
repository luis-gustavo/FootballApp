//
//  MatchesViewControllerTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import SnapshotTesting
import XCTest
@testable import FootballApp

final class MatchesViewControllerTests: XCTestCase {

    private var mockTeamProvider: MockTeamProvider!
    private var mockMatchProvider: MockMatchProvider!
    private var mockRouter: MockMatchesRouter!
    private var viewModel: MatchesViewModel!
    private var sut: MatchesViewController!

    override func setUp() {
        super.setUp()
        mockTeamProvider = .init()
        mockMatchProvider = .init()
        mockRouter = .init()
        viewModel = .init(
            teamProvider: mockTeamProvider,
            matchesProvider: mockMatchProvider,
            router: mockRouter,
            fileManagerProvider: MockFileManagerProvider()
        )
        sut = .init(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        super.tearDown()
        mockMatchProvider = nil
        mockTeamProvider = nil
        mockRouter = nil
        viewModel = nil
        sut = nil
    }

    func testUILightMode() {
        // Given
        let navigationController = UINavigationController(rootViewController: sut)
        navigationController.overrideUserInterfaceStyle = .light
        sut.overrideUserInterfaceStyle = .light

        // When

        // Then
        assertSnapshot(matching: navigationController, as: .image(on: .iPhone12))
        assertSnapshot(matching: sut.view, as: .wait(for: 1, on: .image))
    }

    func testUIDarkMode() {
        // Given
        let navigationController = UINavigationController(rootViewController: sut)
        navigationController.overrideUserInterfaceStyle = .dark
        sut.overrideUserInterfaceStyle = .dark

        // When

        // Then
        assertSnapshot(matching: navigationController, as: .image(on: .iPhone12))
        assertSnapshot(matching: sut.view, as: .wait(for: 1, on: .image))
    }
}
