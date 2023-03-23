//
//  TeamDetailViewModel.swift
//  FootballApp
//
//  Created by Luis Gustavo on 22/03/23.
//

import Combine
import DIContainer
import Foundation

final class TeamDetailViewModel {

    // MARK: - Properties
    let title: String
    @Published private(set) var data: Data?
    private let logoImageUrl: URL?
    private let imageLoader: ImageLoaderProtocol = DIContainer.make(for: ImageLoaderProtocol.self)
    private var bindings = Set<AnyCancellable>()

    // MARK: - Inits
    init(title: String, logoImageUrl: URL?) {
        self.title = title
        self.logoImageUrl = logoImageUrl
    }
}

// MARK: - Internal methods
extension TeamDetailViewModel {
    func fetchImage() {
        guard let logoImageUrl else { return }
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { completion in
            switch completion {
            case.finished:
                break
            case let .failure(error):
                print(error.localizedDescription)
            }
        }

        let valueHandler: (Data) -> Void = { [weak self] data in
            self?.data = data
        }

        imageLoader.downloadImage(logoImageUrl)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
