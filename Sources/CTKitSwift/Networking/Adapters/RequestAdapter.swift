//
//  RequestAdapter.swift
//  CTKitSwift
//
//  Created by Martin Pucik on 05.11.2020.
//

import Foundation
import Combine

protocol RequestAdapting {
    func adapt(_ urlRequest: URLRequest) -> AnyPublisher<URLRequest, Never>
    func onResponse(_ response: URLResponse, data: Data)
}

extension RequestAdapting {
    func adapt(_ urlRequest: URLRequest) -> AnyPublisher<URLRequest, Never> {
        return Future { promise in
            promise(.success(urlRequest))
        }.eraseToAnyPublisher()
    }
    func onResponse(_ response: URLResponse, data: Data) { }
}
