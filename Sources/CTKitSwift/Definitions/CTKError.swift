//
//  CTKError.swift
//  CTKitSwift
//
//  Created by Martin Pucik on 07.11.2020.
//

import Foundation

public enum CTKError: Error, Equatable {
    case urlError(URLError)
    case tokenExpired
    case invalidTokenResponse
    case invalidPlaylistResponse
}
