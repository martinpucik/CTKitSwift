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
        return NetworkingClient.request(resource: Resource.ProgrammeList()).map { $0.programmes }.eraseToAnyPublisher()
    }

    static func playlist(for programme: CTKProgramme) -> AnyPublisher<Response.ProgrammePlaylistPlayURLResponse, Error> {
        return NetworkingClient.request(resource: Resource.ProgrammePlaylist(programme: programme))
            .flatMap { response in
                return NetworkingClient.request(resource: Resource.ProgrammePlaylistPlayURL(playlistResponse: response))
            }
            .eraseToAnyPublisher()
    }
}

extension CTKit {
    static var token: AnyPublisher<String, Error> {
        if let token = CTKDefaults.token {
            return Just(token).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
        return NetworkingClient.request(resource: Resource.Token()).map { $0.token }.eraseToAnyPublisher()
    }
}
