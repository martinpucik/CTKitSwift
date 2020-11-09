//
//  TokenRequestAdapter.swift
//  CTKitSwift
//
//  Created by Martin Pucik on 09.11.2020.
//

import Foundation
import Combine

struct TokenRequestAdapter: RequestAdapting {
    func adapt(_ urlRequest: URLRequest) -> Future<URLRequest, Never> {
        Future { seal in
            guard let body = urlRequest.httpBody,
                  var json = try? JSONSerialization.jsonObject(with: body) as? [String: Any],
                  let token = CTKDefaults.token
            else {
                return seal(.success(urlRequest))
            }
            json["token"] = token
            var newRequest = urlRequest
            newRequest.httpBody = try? JSONSerialization.data(withJSONObject: json)
            seal(.success(newRequest))
        }
    }
}
