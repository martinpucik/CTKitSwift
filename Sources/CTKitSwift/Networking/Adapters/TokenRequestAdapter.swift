//
//  TokenRequestAdapter.swift
//  CTKitSwift
//
//  Created by Martin Pucik on 09.11.2020.
//

import Foundation
import Combine

struct TokenRequestAdapter: RequestAdapting {
    func adapt(_ urlRequest: URLRequest) -> AnyPublisher<URLRequest, Never> {
        return CTKit.token.map { token -> URLRequest in
            var newBody: [String: String] = [:]
            if let data = urlRequest.httpBody,
               let string = String(data: data, encoding: .utf8) {
                for pair in string.components(separatedBy: "&") {
                    let key = pair.components(separatedBy: "=")[0]
                    let value = pair.components(separatedBy: "=")[1]
                    newBody[key] = value
                }
            }
            newBody["token"] = token
            var newRequest = urlRequest
            newRequest.httpBody = newBody.percentEncoded
            return newRequest
        }
        .replaceError(with: urlRequest)
        .eraseToAnyPublisher()
    }
}
