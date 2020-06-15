//
//  CTKitSwift.swift
//  CTKitSwift
//
//  Created by Martin Púčik on 16/03/2020.
//

import Combine

public enum CTKit {

    static func programmes() -> AnyPublisher<[CTKProgramme], Error> {
        let ddd = token().flatMap {
            API.programmelist(token: $0).execute() as AnyPublisher<[CTKProgramme], Error>
        }.eraseToAnyPublisher()

        return ddd
    }
}

private extension CTKit {
    static func token() -> AnyPublisher<String, Error> {
        if let token = CTKDefaults.value(for: "token") as? String {
            return Future<String, Error> { $0(.success(token) }.eraseToAnyPublisher()
        }
        let req: AnyPublisher<CTKToken, Error> = API.token.execute()
        return req.compactMap { $0.value }.eraseToAnyPublisher()
    }
}
