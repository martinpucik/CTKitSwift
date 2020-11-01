//
//  DictionaryExtension.swift
//  CTKitSwift
//
//  Created by Martin Púčik on 17/03/2020.
//

import Foundation

extension Dictionary {
    var percentEncoded: Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}
