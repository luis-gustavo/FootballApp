//
//  ImageLoader.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Combine
import Foundation

final class ImageLoader: ImageLoaderProtocol {

    // MARK: - Properties
    static let shared = ImageLoader()
    private var imageCache = NSCache<NSString, NSData>()

    // MARK: - Init
    private init() { }

    // MARK: - ImageLoaderProtocol
    func downloadImage(_ url: URL) -> AnyPublisher<Data, Error> {
        let key = url.absoluteString as NSString
        if let data = imageCache.object(forKey: key) {
            return Just(data as Data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        let request = URLRequest(url: url)
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {
                $0.data
            }
            .handleEvents(receiveOutput: { [weak self] output in
                let key = url.absoluteString as NSString
                let value = output as NSData
                self?.imageCache.setObject(value, forKey: key)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
