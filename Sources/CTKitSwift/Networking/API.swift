//
//  API.swift
//  CTKitSwift
//
//  Created by Martin Púčik on 16/03/2020.
//

import Foundation
import Combine
import SWXMLHash

enum API {

    case token
    case programmelist(token: String)

    // MARK: - Private properties

    private static let baseURL: String = "https://www.ceskatelevize.cz"

    private static let defaultHeaders: [String: String] = [
        "Content-type": "application/x-www-form-urlencoded",
        "Accept-encoding": "gzip",
        "Connection": "Keep-Alive",
        "User-Agent": "Dalvik/1.6.0 (Linux; U; Android 4.4.4; Nexus 7 Build/KTU84P)"
    ]

    private var path: String {
        switch self {
            case .token: return "/services/ivysilani/xml/token/"
            case .programmelist: return "/services/ivysilani/xml/programmelist/"
        }
    }

    private var method: String {
        switch self {
            case .token, .programmelist: return "POST"
        }
    }

    private var body: Data? {
        switch self {
        case .token: return ["user": "iDevicesMotion"].percentEncoded
        case .programmelist(let token): return ["token": token, "imageType": "1280", "current": "1"].percentEncoded
        }
    }

    private var request: URLRequest {
        guard let url = URL(string: "\(API.baseURL)\(path)") else {
            fatalError("CTKitSwift: Can't construct URL for API route")
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = API.defaultHeaders
        request.httpMethod = method
        request.httpBody = body
        return request
    }

    // MARK: - Public methods

    public func execute<T: XMLDecodable>() -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryCompactMap { (data, _) -> T? in
                let xml = SWXMLHash.parse(data)
                if xml["errors"]["error"].element?.text == "wrong token" {
                    throw APIError.wrongToken
                }
                return try T(xmlObject: xml)
            }
            .eraseToAnyPublisher()
    }
}

extension API {
    enum APIError: Error {
        typealias RawValue = String
        case wrongToken
    }
}
