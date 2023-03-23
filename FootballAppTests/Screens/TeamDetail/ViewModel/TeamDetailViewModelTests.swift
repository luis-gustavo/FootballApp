//
//  TeamDetailViewModelTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import XCTest
@testable import FootballApp

final class TeamDetailViewModelTests: XCTestCase {

    private var sut: TeamDetailViewModel!

    override func setUp() {
        super.setUp()
        sut = .init(
            title: "Team Red Dragons",
            logoImageUrl: Bundle(for: ImageLoaderTests.self).url(forResource: "ball", withExtension: "png")
        )
    }

    func testProperties() throws {
        // Given
        guard let url = Bundle(for: ImageLoaderTests.self).url(forResource: "ball", withExtension: "png") else {
            XCTFail("Url must exist")
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            XCTFail("Data must exist")
            return
        }

        // When
        sut.fetchImage()

        // Then
        XCTAssertEqual(sut.title, "Team Red Dragons")
        XCTAssertNotNil(sut.data)
        XCTAssertEqual(sut.data, data)
    }
}
