//
//  MatchCellViewModelTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import XCTest
@testable import FootballApp

final class MatchCellViewModelTests: XCTestCase {

    private var sut: MatchCellViewModel!

    func testProperties() throws {
        // Given
        let dateHeaderViewModel = DateHeaderViewModel(date: "2022-04-23T16:00:00.000Z")
        let highlightFooterViewModel = HighlightFooterViewModel()
        let homeViewModel = TeamViewModel(
            title: "Team Red Dragons",
            imageUrl: .init(string: "hhtps://www.google.com"),
            status: .winner
        )
        let awayViewModel = TeamViewModel(
            title: "Team Cool Eagles",
            imageUrl: .init(string: "hhtps://www.google.com"),
            status: .loser
        )

        // When
        sut = MatchCellViewModel(
            dateHeaderViewModel: dateHeaderViewModel,
            highlightFooterViewModel: highlightFooterViewModel,
            homeViewModel: homeViewModel,
            awayViewModel: awayViewModel,
            showHighlight: true
        )

        // Then
        XCTAssertEqual(sut.dateHeaderViewModel.date, dateHeaderViewModel.date)
        XCTAssertEqual(sut.homeViewModel.title, homeViewModel.title)
        XCTAssertEqual(sut.homeViewModel.status, homeViewModel.status)
        XCTAssertEqual(sut.awayViewModel.title, awayViewModel.title)
        XCTAssertEqual(sut.awayViewModel.status, awayViewModel.status)
    }
}
