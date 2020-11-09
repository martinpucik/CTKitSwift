//
//  NetworkingClient.swift
//  CTKitSwift
//
//  Created by Martin Púčik on 16/03/2020.
//

import Foundation
import Combine
import SWXMLHash

enum NetworkingClient {

    // MARK: - Private properties

    private static let baseURL: String = "https://www.ceskatelevize.cz"

    private static let defaultHeaders: [String: String] = [
        "Content-type": "application/x-www-form-urlencoded",
        "Accept-encoding": "gzip",
        "Connection": "Keep-Alive",
        "User-Agent": "Dalvik/1.6.0 (Linux; U; Android 4.4.4; Nexus 7 Build/KTU84P)"
    ]

    // MARK: - Public methods

    static func request<T: ResourceProviding>(resource: T) -> AnyPublisher<T.ResponseType, Error> {
        let request = makeRequest(resource: resource)
        return Interceptor(request: request, adapters: resource.adapters)
            .flatMap(URLSession.shared.dataTaskPublisher(for:))
            .mapError { CTKError.urlError($0) }
            .tryCompactMap { try T.ResponseType(data: $0.0) }
            .eraseToAnyPublisher()
    }
}

extension NetworkingClient {
    private static func makeRequest<T: ResourceProviding>(resource: T) -> URLRequest {
        // path must have a slash to be valid component URL
        let validPath: String = !resource.path.hasPrefix("/") ? "/\(resource.path)" : resource.path
        var request = URLRequest(url: URL(string: "\(baseURL)\(validPath)")!)
        request.httpMethod = resource.method.rawValue
        request.allHTTPHeaderFields = defaultHeaders.merging(resource.headers ?? [:]) {(current, _) in current}
        if let body = resource.body {
            request.httpBody = body.percentEncoded
        }
        return request
    }
}
