//
//  TokenResponseRequestAdapter.swift
//  CTKitSwift
//
//  Created by Martin Pucik on 16.11.2020.
//

import Foundation
import Combine
import SWXMLHash

struct TokenResponseRequestAdapter: RequestAdapting {
    func onResponse(_ response: URLResponse, data: Data) {
        guard let token = SWXMLHash.parse(data)["token"].element?.text, !token.isEmpty else {
            return
        }
        CTKDefaults.token = token
    }
}
