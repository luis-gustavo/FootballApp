//
//  TeamViewModelTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import Combine
import XCTest
@testable import FootballApp

final class TeamViewModelTests: XCTestCase {

    private var sut: TeamViewModel!
    private var bindings = Set<AnyCancellable>()

    override func setUp() {
        sut = TeamViewModel(
            title: "Team Red Dragons",
            imageUrl: .init(string: "https://www.google.com"),
            status: .winner
        )
    }

    override func tearDown() {
        sut = nil
    }

    func testProperties() {
        // Given

        // When

        // Then
        XCTAssertEqual(sut.title, "Team Red Dragons")
        XCTAssertEqual(sut.status, .winner)
    }

    func testFetchImage() {
        // Given
        let expectation = expectation(description: "fetched image")

        // When
        sut.fetchImage()

        // Then
        sut.$data
            .sink { data in
                // Then
                XCTAssertNotNil(data)
                expectation.fulfill()
            }
            .store(in: &bindings)
        wait(for: [expectation], timeout: 1)
    }

    func testTappedDetail() {
        // Given
        let expectation = expectation(description: "tapped show team detail")
        sut.tappedTeamDetail
            .sink { teamName in
                XCTAssertEqual(teamName, self.sut.title)
                expectation.fulfill()
            }
            .store(in: &bindings)

        // When
        sut.showTeamDetail()

        // Then
        wait(for: [expectation], timeout: 1)
    }
}
