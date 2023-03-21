//
//  ImageLoaderProtocol.swift
//  FootballApp
//
//  Created by Luis Gustavo on 21/03/23.
//

import Combine
import Foundation

protocol ImageLoaderProtocol {
    func downloadImage(_ url: URL) -> AnyPublisher<Data, Error>
}
