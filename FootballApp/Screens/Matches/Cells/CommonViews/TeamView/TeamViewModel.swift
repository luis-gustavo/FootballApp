//
//  TeamViewModel.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Combine
import Foundation
import DIContainer

final class TeamViewModel {

    // MARK: - State
    enum State {
        case loading, finishedLoading
    }

    enum Status {
        case winner, loser, idle
    }

    // MARK: - Properties
    let title: String
    let status: TeamViewModel.Status
    @Published private(set) var data: Data?
    @Published private(set) var state: State = .loading
    private let imageUrl: URL?
    private let imageLoader: ImageLoaderProtocol = DIContainer.make(for: ImageLoaderProtocol.self)
    private var bindings = Set<AnyCancellable>()

    // MARK: - Init
    init(
        title: String,
        imageUrl: URL?,
        status: TeamViewModel.Status
    ) {
        self.title = title
        self.imageUrl = imageUrl
        self.status = status
    }
}

// MARK: - Internal methods
extension TeamViewModel {
    func fetchImage() {
        guard let url = imageUrl else { return }
        state = .loading

        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case.finished:
                self?.state = .finishedLoading
            case let .failure(error):
                print(error.localizedDescription)
            }
        }

        let valueHandler: (Data) -> Void = { [weak self] data in
            self?.data = data
        }

        imageLoader
            .downloadImage(url)
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &bindings)
    }
}
