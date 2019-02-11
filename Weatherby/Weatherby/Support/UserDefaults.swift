//
//  UserDefaults.swift
//  Weatherby
//
//  Created by Reka Vihari on 2019. 02. 10..
//  Copyright © 2019. Reka Vihari. All rights reserved.
//

import Foundation
import MapKit

extension UserDefaults {
    
    enum UserDefaultsKey: String {
        case apikey
    }

    func setApiKey(value: String) {
        set(value, forKey: UserDefaultsKey.apikey.rawValue)
        synchronize()
    }

    func getApiKey() -> String {
        guard let token = UserDefaults.standard.string(forKey: "apikey") else { return ""}
        return token
    }
}

