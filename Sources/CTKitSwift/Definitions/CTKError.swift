//
//  CTKError.swift
//  CTKitSwift
//
//  Created by Martin Pucik on 07.11.2020.
//

import Foundation

public enum CTKError: Error {
    case urlError(URLError)
    case invalidTokenResponse
}
