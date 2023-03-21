import XCTest
@testable import DIContainer

final class DIContainerTests: XCTestCase {

    private let container = DIContainer.default

    func testCreatingService() throws {

        // Given
        container.register(MockService.self) { MockService.one }

        // When
        let retrievedService: MockService = container.make(for: MockService.self)

        // Then
        XCTAssert(retrievedService == MockService.one)
    }

    func testComparingDifferentServices() throws {

        // Given
        container.register(MockService.self) { MockService.one }

        // When
        let retrievedService: MockService = container.make(for: MockService.self)

        // Then
        XCTAssert(retrievedService != MockService.two)
    }
}

private enum MockService {
    case one, two
}

