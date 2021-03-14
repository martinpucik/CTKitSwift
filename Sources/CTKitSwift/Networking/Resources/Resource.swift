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
        let adapters: [RequestAdapting] = [TokenResponseRequestAdapter()]
        typealias ResponseType = Response.TokenResponse
    }
    
    struct ProgrammeList: ResourceProviding {
        let method: HttpMethod = .POST
        let path: String = "/services/ivysilani/xml/programmelist/"
        let body: [String: String]? = ["imageType": "1280", "current": "1"]
        let adapters: [RequestAdapting] = [TokenRequestAdapter()]
        typealias ResponseType = Response.ProgrammeListResponse
    }

    struct ProgrammePlaylist: ResourceProviding {
        let method: HttpMethod = .POST
        let path: String = "/services/ivysilani/xml/playlisturl/"
        let body: [String: String]?// = ["imageType": "1280", "current": "1"]
        let adapters: [RequestAdapting] = [TokenRequestAdapter()]
        typealias ResponseType = Response.ProgrammePlaylistResponse

        init(programmeID: String, isVOD: Bool) {
            let quality: String = isVOD ? "max720p" : "web"
            let playerType: String = isVOD ? "progressive" : "ios"
            let params = [
                "ID": programmeID,
                "quality": quality,
                "playerType": playerType,
            ]
            self.body = params
        }
    }

    struct ProgrammePlaylistPlayURL: ResourceProviding {
        let method: HttpMethod = .GET
        let path: String
        let body: [String: String]? = nil
        let adapters: [RequestAdapting] = []
        typealias ResponseType = Response.ProgrammePlaylistPlayURLResponse

        init(playlistResponse: Response.ProgrammePlaylistResponse) {
            guard let components = URLComponents(string: playlistResponse.playlistURLString) else {
                self.path = playlistResponse.playlistURLString
                return
            }
            self.path = "\(components.path)?\(components.query ?? "")" 
        }
    }
}
