//
//  XMLDecodable.swift
//  CTKitSwift
//
//  Created by Martin Púčik on 17/03/2020.
//

import Foundation
import SWXMLHash

enum XMLDecodableError: Error {
    case xmlDecodingFailed
}

protocol XMLDecodable {
    init(xmlObject: XMLIndexer) throws
}
