//
//  CTKToken.swift
//  CTKitSwift
//
//  Created by Martin Púčik on 18/03/2020.
//

import Foundation
import SWXMLHash

struct CTKToken: XMLDecodable {
    let value: String 

    init(xmlObject: XMLIndexer) throws {
        guard let token = xmlObject["token"].element?.text, !token.isEmpty else {
            throw XMLDecodableError.xmlDecodingFailed
        }
        value = token
        CTKDefaults.token = value
    }
}
