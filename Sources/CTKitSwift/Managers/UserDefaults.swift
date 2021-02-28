//
//  UserDefaults.swift
//  CTKitSwift
//
//  Created by Martin Púčik on 18/03/2020.
//

import Foundation

@propertyWrapper struct UserDefaultsBacked<Value> {
    private let key: String
    private let storage: UserDefaults?

    init(key: String, storage: UserDefaults? = CTKDefaults.defaults) {
        self.key = key
        self.storage = storage
    }
    
    var wrappedValue: Value? {
        get { storage?.value(forKey: key) as? Value }
        set { storage?.setValue(newValue, forKey: key) }
    }
}

struct CTKDefaults {
    
    fileprivate static let defaults: UserDefaults? = UserDefaults(suiteName: "com.martinpucik.CTKitSwift")
    
    @UserDefaultsBacked(key: "token")
    static var token: String?
}
