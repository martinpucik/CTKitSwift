//
//  RequestAdapter.swift
//  CTKitSwift
//
//  Created by Martin Pucik on 05.11.2020.
//

import Foundation
import Combine

protocol RequestAdapting {
    func adapt(_ urlRequest: URLRequest) -> Future<URLRequest, Never>
}
