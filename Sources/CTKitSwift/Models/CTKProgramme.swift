//
//  CTKProgramme.swift
//  CTKitSwift
//
//  Created by Martin Púčik on 17/03/2020.
//

import Foundation
import SWXMLHash

public struct CTKProgramme {

    // MARK: - Public properties

    public let id: String
    public let title: String
    public let channelName: String
    public let previewImageURLString: String
    public let isVOD: Bool
    public let startTime: Date?
    public let synopsis: String?
    public let elapsedPercentage: String?

    // MARK: - Lifecycle

    init?(xmlObject: XMLIndexer) {
        guard
            let id = xmlObject["live"]["programme"]["ID"].element?.text,
            let name = xmlObject["live"]["programme"]["channelTitle"].element?.text,
            !name.isEmpty,
            let preview = xmlObject["live"]["programme"]["imageURL"].element?.text,
            let isVod = xmlObject["live"]["programme"]["isVod"].element?.text,
            let title = xmlObject["live"]["programme"]["title"].element?.text
        else {
            return nil
        }
        self.id = id
        self.title = title
        self.channelName = name
        self.previewImageURLString = preview
        self.isVOD = isVod == "1"
        self.synopsis = xmlObject["live"]["programme"]["synopsis"].element?.text
        self.elapsedPercentage = xmlObject["live"]["programme"]["elapsedPercentage"].element?.text
        if let unix = xmlObject["live"]["programme"]["unixTime"].element?.text {
            let unixTimeInterval = Double(unix) ?? 0
            self.startTime = Date(timeIntervalSince1970: unixTimeInterval)
        } else {
            self.startTime = nil
        }
    }
}
