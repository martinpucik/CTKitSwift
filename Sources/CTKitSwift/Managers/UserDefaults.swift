//
//  UserDefaults.swift
//  CTKitSwift
//
//  Created by Martin Púčik on 18/03/2020.
//

import Foundation

final class CTKDefaults {
    private static var defaults: UserDefaults? { UserDefaults(suiteName: "com.martinpucik.CTKitSwift") }

    static func set(_ value: Any?, key: String) {
        defaults?.set(value, forKey: key)
    }

    static func value(for key: String) -> Any? {
        defaults?.value(forKey: key)
    }
}
