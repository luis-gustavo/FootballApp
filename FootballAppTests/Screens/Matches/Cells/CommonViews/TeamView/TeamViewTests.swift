//
//  TeamViewTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import SnapshotTesting
import XCTest
@testable import FootballApp

final class TeamViewTests: XCTestCase {

    private var sut: TeamView!

    override func setUp() {
        sut = .init()
        sut.frame = .init(origin: .zero, size: .init(width: 100, height: 100))
    }

    override func tearDown() {
        sut = nil
    }

    func testUIAsWinner() {
        // Given
        let viewModel = TeamViewModel(
            title: "Team Red Dragons",
            imageUrl: .init(string: "https://www.google.com"),
            status: .winner
        )

        // When
        sut.configure(with: viewModel)

        // Then
        sut.overrideUserInterfaceStyle = .light
        assertSnapshot(matching: sut, as: .wait(for: 1, on: .image))
        sut.overrideUserInterfaceStyle = .dark
        assertSnapshot(matching: sut, as: .wait(for: 1, on: .image))
    }

    func testUIAsLoser() {
        // Given
        let viewModel = TeamViewModel(
            title: "Team Red Dragons",
            imageUrl: .init(string: "https://www.google.com"),
            status: .loser
        )

        // When
        sut.configure(with: viewModel)

        // Then
        sut.overrideUserInterfaceStyle = .light
        assertSnapshot(matching: sut, as: .wait(for: 1, on: .image))
        sut.overrideUserInterfaceStyle = .dark
        assertSnapshot(matching: sut, as: .wait(for: 1, on: .image))
    }

    func testUIAsIdle() {
        // Given
        let viewModel = TeamViewModel(
            title: "Team Red Dragons",
            imageUrl: .init(string: "https://www.google.com"),
            status: .idle
        )

        // When
        sut.configure(with: viewModel)

        // Then
        sut.overrideUserInterfaceStyle = .light
        assertSnapshot(matching: sut, as: .wait(for: 1, on: .image))
        sut.overrideUserInterfaceStyle = .light
        assertSnapshot(matching: sut, as: .wait(for: 1, on: .image))
    }
}
