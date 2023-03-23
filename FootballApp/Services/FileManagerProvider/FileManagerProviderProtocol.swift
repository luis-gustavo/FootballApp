//
//  FileManagerProviderProtocol.swift
//  FootballApp
//
//  Created by Luis Gustavo on 23/03/23.
//

import Combine
import Foundation

protocol FileManagerProviderProtocol {
    func saveToDocuments(name: String)
    func retrieveUrlFromDocuments(name: String) -> URL?
    func fileExists(name: String) -> Bool
}

extension FileManagerProviderProtocol {
    func saveToDocuments(name: String) {
        guard let url = URL(string: name) else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        guard let fileName = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appending(path: name.replacingOccurrences(of: "/", with: "")) else { return }
        do {
            try data.write(to: fileName, options: [.atomic])
        } catch {
            print(error.localizedDescription)
        }
    }

    func fileExists(name: String) -> Bool {
        guard let url = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first?.appending(component: name.replacingOccurrences(of: "/", with: "")) else {
            return false
        }
//        let path = "file://\(url.path)"
        return FileManager.default.fileExists(atPath: url.path())
    }

    func retrieveUrlFromDocuments(name: String) -> URL? {
        FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask)
        .first?.appending(component: name.replacingOccurrences(of: "/", with: ""))
    }
}
