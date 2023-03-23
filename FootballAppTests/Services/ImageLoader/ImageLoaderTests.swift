//
//  ImageLoaderTests.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import Combine
import XCTest
@testable import FootballApp

final class ImageLoaderTests: XCTestCase {

    private var bindings = Set<AnyCancellable>()

    func testImageLoader() throws {
        // Given
        guard let url = Bundle(for: ImageLoaderTests.self).url(forResource: "ball", withExtension: "png") else {
            XCTFail("Failed to create url")
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            XCTFail("Failed to read contents of \(url)")
            return
        }
        let expectation = self.expectation(description: "Image loading")

        // When
        ImageLoader.shared.downloadImage(url)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Failed to download image")
                default:
                    break
                }
            }, receiveValue: { imageData in
                // Then
                XCTAssertEqual(data, imageData)
                expectation.fulfill()
            })
            .store(in: &bindings)

        wait(for: [expectation], timeout: 1)
    }
}
