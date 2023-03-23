//
//  MockFileManagerProvider.swift
//  FootballAppTests
//
//  Created by Luis Gustavo on 23/03/23.
//

import Foundation
@testable import FootballApp

final class MockFileManagerProvider: FileManagerProviderProtocol {
    // MARK: - FileManagerProviderProtocol
    func saveToDocuments(name: String) { }
    func retrieveUrlFromDocuments(name: String) -> URL? { nil }
    func fileExists(name: String) -> Bool { false }
}
