//
//  CTKitSwift.swift
//  CTKitSwift
//
//  Created by Martin Púčik on 16/03/2020.
//

import Foundation
import Combine

public enum CTKit {
    static func programmes() -> AnyPublisher<[CTKProgramme], Error> {
        return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
//        let ddd = token.flatMap {
//            API.programmelist(token: $0).execute() as AnyPublisher<[CTKProgramme], Error>
//        }.eraseToAnyPublisher()
//
//        return ddd
    }
}

private extension CTKit {
    static var token: AnyPublisher<String, Error> {
        Just(CTKDefaults.token).setFailureType(to: Error.self).replaceNil(with: "").eraseToAnyPublisher()
//        let req: AnyPublisher<CTKToken, Error> = API.token.execute()
//        return req.compactMap { $0.value }.eraseToAnyPublisher()
    }
}
