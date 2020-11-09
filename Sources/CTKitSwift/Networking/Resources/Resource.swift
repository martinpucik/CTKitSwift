//
//  Resource.swift
//  CTKitSwift
//
//  Created by Martin Pucik on 02.11.2020.
//

import Foundation

enum HttpMethod: String {
    case GET
    case PUT
    case POST
    case DELETE
    case HEAD
}

protocol ResourceProviding {
    associatedtype ResponseType: ResponseProviding
    var method: HttpMethod { get }
    var path: String { get }
    var body: [String: String]? { get }
    var headers: [String: String]? { get }
    var adapters: [RequestAdapting] { get }
}

extension ResourceProviding {
    var method: HttpMethod { .GET }
    var body: [String: String]? { nil }
    var headers: [String: String]? { nil }
    var adapters: [RequestAdapting] { [RequestAdapting]() }
}

// MARK: - Resources

enum Resource {
    struct Token: ResourceProviding {
        let method: HttpMethod = .POST
        let path: String = "/services/ivysilani/xml/token/"
        let body: [String: String]? = ["user": "iDevicesMotion"]
        typealias ResponseType = Response.TokenResponse
    }
    
    struct ProgrammeList: ResourceProviding {
        let path: String = "/services/ivysilani/xml/programmelist/"
        let body: [String: String]? = ["imageType": "1280", "current": "1"]
        let adapters: [RequestAdapting] = [TokenRequestAdapter()]
        typealias ResponseType = Response.TokenResponse

    }
}
