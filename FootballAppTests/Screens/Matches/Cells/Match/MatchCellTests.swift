//
//  MatchCellTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import XCTest
import SnapshotTesting
@testable import FootballApp

final class MatchCellTests: XCTestCase {

    private var sut: MatchCell!
    private var viewModel: MatchCellViewModel!

    override func setUp() {
        sut = MatchCell(frame: .init(origin: .zero, size: .init(width: 300, height: 250)))
    }

    override func tearDown() {
        sut = nil
        viewModel = nil
    }

    func testUIWithHighlightsLight() {
        // Given
        viewModel = MatchCellViewModel(
            dateHeaderViewModel: .init(date: "2022-04-23T16:00:00.000Z"),
            highlightFooterViewModel: .init(),
            homeViewModel: .init(
                title: "Team Red Dragons",
                imageUrl: .init(string: "hhtps://www.google.com"),
                status: .winner
            ),
            awayViewModel: .init(
                title: "Team Cool Eagles",
                imageUrl: .init(string: "hhtps://www.google.com"),
                status: .loser
            ),
            showHighlight: true
        )
        sut.overrideUserInterfaceStyle = .light

        // When
        sut.configure(with: viewModel)

        // Then
        assertSnapshot(matching: sut, as: .wait(for: 2, on: .image))
    }

    func testUIWithHighlightsDark() {
        // Given
        viewModel = MatchCellViewModel(
            dateHeaderViewModel: .init(date: "2022-04-23T16:00:00.000Z"),
            highlightFooterViewModel: .init(),
            homeViewModel: .init(
                title: "Team Red Dragons",
                imageUrl: .init(string: "hhtps://www.google.com"),
                status: .winner
            ),
            awayViewModel: .init(
                title: "Team Cool Eagles",
                imageUrl: .init(string: "hhtps://www.google.com"),
                status: .loser
            ),
            showHighlight: true
        )
        sut.overrideUserInterfaceStyle = .dark

        // When
        sut.configure(with: viewModel)

        // Then
        assertSnapshot(matching: sut, as: .wait(for: 2, on: .image))
    }

    func testUIWithoutHighlightsLight() {
        // Given
        viewModel = MatchCellViewModel(
            dateHeaderViewModel: .init(date: "2022-04-23T16:00:00.000Z"),
            highlightFooterViewModel: .init(),
            homeViewModel: .init(
                title: "Team Red Dragons",
                imageUrl: .init(string: "hhtps://www.google.com"),
                status: .winner
            ),
            awayViewModel: .init(
                title: "Team Cool Eagles",
                imageUrl: .init(string: "hhtps://www.google.com"),
                status: .loser
            ),
            showHighlight: false
        )
        sut.overrideUserInterfaceStyle = .light

        // When
        sut.configure(with: viewModel)

        // Then
        assertSnapshot(matching: sut, as: .wait(for: 2, on: .image))
    }

    func testUIWithoutHighlightsDark() {
        // Given
        viewModel = MatchCellViewModel(
            dateHeaderViewModel: .init(date: "2022-04-23T16:00:00.000Z"),
            highlightFooterViewModel: .init(),
            homeViewModel: .init(
                title: "Team Red Dragons",
                imageUrl: .init(string: "hhtps://www.google.com"),
                status: .winner
            ),
            awayViewModel: .init(
                title: "Team Cool Eagles",
                imageUrl: .init(string: "hhtps://www.google.com"),
                status: .loser
            ),
            showHighlight: false
        )
        sut.overrideUserInterfaceStyle = .dark

        // When
        sut.configure(with: viewModel)

        // Then
        assertSnapshot(matching: sut, as: .wait(for: 2, on: .image))
    }
}
