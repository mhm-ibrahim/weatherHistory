//
//  UserDefaults.swift
//  Weather History
//
//  Created by Mohamed Hamed on 12/28/17.
//  Copyright © 2017 Hamed. All rights reserved.
//

import Foundation

enum UserDefaultsKey: String {
    case token
}

extension UserDefaults {
    
    static func set(_ value:Any, forKey key: UserDefaultsKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func object(forKey key: UserDefaultsKey) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }
    
    static func remove(forKey key: UserDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
