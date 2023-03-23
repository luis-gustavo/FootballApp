//
//  MatchesViewModelTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import XCTest
@testable import FootballApp

final class MatchesViewModelTests: XCTestCase {

    private var mockTeamProvider: MockTeamProvider!
    private var mockMatchProvider: MockMatchProvider!
    private var mockRouter: MockMatchesRouter!
    private var sut: MatchesViewModel!

    override func setUp() {
        super.setUp()
        mockTeamProvider = .init()
        mockMatchProvider = .init()
        mockRouter = .init()
        sut = .init(
            teamProvider: mockTeamProvider,
            matchesProvider: mockMatchProvider,
            router: mockRouter
        )
    }

    override func tearDown() {
        super.tearDown()
        mockMatchProvider = nil
        mockTeamProvider = nil
        mockRouter = nil
        sut = nil
    }

    func testMatchesWithoutFilter() {
        // Given

        // When
        sut.fetchData()

        // Then
        XCTAssertEqual(sut.filteredPreviousMatches.count, 2)
        XCTAssertEqual(sut.filteredPreviousMatches.first?.away, "Team Red Dragons")
        XCTAssertEqual(sut.filteredUpcomingMatches.count, 2)
        XCTAssertEqual(sut.filteredUpcomingMatches.first?.away, "Team Cool Eagles")
    }

    func testMatchesWithFilter() {
        // Given

        // When
        sut.fetchData()
        sut.updateSearchText("Team Cool Eagles")

        // Then
        XCTAssertEqual(sut.filteredPreviousMatches.count, 1)
        XCTAssertEqual(sut.filteredPreviousMatches.first?.home, "Team Cool Eagles")
        XCTAssertEqual(sut.filteredUpcomingMatches.count, 2)
        XCTAssertEqual(sut.filteredUpcomingMatches.first?.home, "Team Red Dragons")
    }

    func testRoutingToShowError() {
        // Given
        let error = URLError(.badURL)

        // When
        sut.showError(error)

        // Then
        XCTAssertEqual(mockRouter.tappedShowError, true)
    }

    func testCellViewModelForPreviousMatch() {
        // Given
        sut.fetchData()
        guard let previousMatch = sut.filteredPreviousMatches.first else {
            XCTFail("Match must exist")
            return
        }

        // When
        let viewModel = sut.cellViewModel(for: .previous(previousMatch))

        // Then
        XCTAssertEqual(viewModel.showHighlight, true)
        XCTAssertEqual(viewModel.homeViewModel.title, "Team Cool Eagles")
        XCTAssertEqual(viewModel.awayViewModel.title, "Team Red Dragons")
    }

    func testCellViewModelForUpcomingMatch() {
        // Given
        sut.fetchData()
        guard let previousMatch = sut.filteredUpcomingMatches.first else {
            XCTFail("Match must exist")
            return
        }

        // When
        let viewModel = sut.cellViewModel(for: .upcoming(previousMatch))

        // Then
        XCTAssertEqual(viewModel.showHighlight, false)
        XCTAssertEqual(viewModel.homeViewModel.title, "Team Red Dragons")
        XCTAssertEqual(viewModel.awayViewModel.title, "Team Cool Eagles")
    }

    func testCellViewModelForUpcomingMatcha() {
        // Given
        sut.fetchData()
        guard let previousMatch = sut.filteredUpcomingMatches.first else {
            XCTFail("Match must exist")
            return
        }

        // When
        let viewModel = sut.cellViewModel(for: .upcoming(previousMatch))

        // Then
        XCTAssertEqual(viewModel.showHighlight, false)
        XCTAssertEqual(viewModel.homeViewModel.title, "Team Red Dragons")
        XCTAssertEqual(viewModel.awayViewModel.title, "Team Cool Eagles")
    }
}
