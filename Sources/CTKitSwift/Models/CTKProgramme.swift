//
//  CTKProgramme.swift
//  CTKitSwift
//
//  Created by Martin Púčik on 17/03/2020.
//

import Foundation
import SWXMLHash

public struct CTKProgramme: XMLDecodable {
    let id: String

    init(xmlObject: XMLIndexer) throws {
        id = ""
        print(xmlObject)
    }
}

extension Array: XMLDecodable where Element: XMLDecodable {
    init(xmlObject: XMLIndexer) throws {
        print(xmlObject)
        let channels = try xmlObject["programmes"].children.compactMap { try CTKProgramme(xmlObject: $0) }
        self.init()
        if let el = channels as? [Element] {
            self.append(contentsOf: el)
        }
    }
}
