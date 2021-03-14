//
//  CTKitSwift.swift
//  CTKitSwift
//
//  Created by Martin Púčik on 16/03/2020.
//

import Foundation
import Combine

public enum CTKit {
    public static func programmes() -> AnyPublisher<[CTKProgramme], Error> {
        return NetworkingClient.request(resource: Resource.ProgrammeList()).map { $0.programmes }.eraseToAnyPublisher()
    }

    public static func playlist(programmeID: String) -> AnyPublisher<String, Error> {
        return NetworkingClient.request(resource: Resource.ProgrammePlaylist(programmeID: programmeID, isVOD: true))
            .flatMap { response in
                return NetworkingClient.request(resource: Resource.ProgrammePlaylistPlayURL(playlistResponse: response))
            }
            .map { $0.playURLString }
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
