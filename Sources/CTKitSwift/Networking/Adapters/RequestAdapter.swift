//
//  RequestAdapter.swift
//  CTKitSwift
//
//  Created by Martin Pucik on 05.11.2020.
//

import Foundation

protocol RequestAdapting {
    func adapt(_ urlRequest: URLRequest, completion: @escaping (Result<URLRequest, Error>) -> Void)
}
