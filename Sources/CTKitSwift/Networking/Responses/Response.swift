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
}

// MARK: - Responses

enum Response {
    struct TokenResponse: ResponseProviding {
        let token: String
        
        init(data: Data) throws {
            guard let token = SWXMLHash.parse(data)["token"].element?.text else {
                throw CTKError.invalidTokenResponse
            }
            self.token = token
        }
    }

    struct ProgrammeListResponse: ResponseProviding {
        let programmes: [CTKProgramme]

        init(data: Data) throws {
            let xml = SWXMLHash.parse(data)
            let programmes = xml["programmes"].children.compactMap { CTKProgramme(xmlObject: $0) }
            self.programmes = programmes
        }
    }
}
