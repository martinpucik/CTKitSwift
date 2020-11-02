//
//  UserDefaults.swift
//  CTKitSwift
//
//  Created by Martin Púčik on 18/03/2020.
//

import Foundation
import Combine

struct CTKDefaults {
    
    static let defaults: UserDefaults? = UserDefaults(suiteName: "com.martinpucik.CTKitSwift")
    
    @UserDefaultsBacked(key: "token")
    static var token: String?
}

@propertyWrapper struct UserDefaultsBacked<Value> {
    let key: String
    let storage: UserDefaults? = CTKDefaults.defaults

    var wrappedValue: Value? {
        get {
            storage?.value(forKey: key) as? Value
        }
        set {
            storage?.setValue(newValue, forKey: key)
        }
    }
    
    var publisherValue: AnyPublisher<Any?, Error> {
        return Result.Publisher(wrappedValue).eraseToAnyPublisher()
    }
}
