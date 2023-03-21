//
//  URLSessionNetworkingProtocol.swift
//  
//
//  Created by Luis Gustavo 21 16/03/23.
//

import Combine
import Foundation

public protocol URLSessionNetworkingProtocol {
    @available(iOS 13.0, *)
    func request(endPoint: EndPoint) -> AnyPublisher<NetworkResponse, NetworkError>
}
