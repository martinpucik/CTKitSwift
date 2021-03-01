//
//  Response.swift
//  CTKitSwift
//
//  Created by Martin Pucik on 02.11.2020.
//

import Foundation
import SWXMLHash

protocol ResponseProviding {
    init(data: Data) throws
    static func parseXML(data: Data) throws -> XMLIndexer
}

extension ResponseProviding {
    static func parseXML(data: Data) throws -> XMLIndexer {
        let xml = SWXMLHash.parse(data)
        if let error = xml["errors"]["error"].element?.text, error == "wrong token" {
            throw CTKError.tokenExpired
        }
        return xml
    }
}

// MARK: - Responses

enum Response {
    struct TokenResponse: ResponseProviding {
        let token: String
        
        init(data: Data) throws {
            guard let token = try Self.parseXML(data: data)["token"].element?.text else {
                throw CTKError.invalidTokenResponse
            }
            self.token = token
        }
    }

    struct ProgrammeListResponse: ResponseProviding {
        let programmes: [CTKProgramme]

        init(data: Data) throws {
            let xml = try Self.parseXML(data: data)
            let programmes = xml["programmes"].children.compactMap { CTKProgramme(xmlObject: $0) }
            self.programmes = programmes
        }
    }

    struct ProgrammePlaylistResponse: ResponseProviding {
        let playlistURLString: String

        init(data: Data) throws {
            let xml = try Self.parseXML(data: data)
            guard let playlistURL = xml["playlistURL"].element?.text, !playlistURL.isEmpty else {
                throw CTKError.invalidPlaylistResponse
            }
            self.playlistURLString = playlistURL
        }
    }

    struct ProgrammePlaylistPlayURLResponse: ResponseProviding {
        let playURLString: String

        init(data: Data) throws {
            let xml = try Self.parseXML(data: data)
            guard let url = xml["data"]["smilRoot"]["body"]["video"].element?.attribute(by: "src")?.text, !url.isEmpty else {
                throw CTKError.invalidPlaylistResponse
            }
            self.playURLString = url
        }
    }
}
