//
//  NetworkService.swift
//  Weatherby
//
//  Created by Reka Vihari on 2019. 02. 10..
//  Copyright © 2019. Reka Vihari. All rights reserved.
//

import Foundation
import Alamofire

enum Endpoints: String {
    case budapest = "3054643"
    case keszthely = "3050212"
    case esztergom = "3053163"
    case szolnok = "715126"
}

typealias ResponseType = ((Data?, Error?) -> Void)?

class NetworkService {

    static let shared = NetworkService()
    private let baseUrl = URL(string:"http://api.openweathermap.org/data/2.5/weather")

    private init () {
        UserDefaults.standard.setApiKey(value: "b8e9bb3ddb745944182c7c00c66a7edb")
    }

    func get(endpoint: Endpoints, completion: ResponseType) {
        let apiKey = UserDefaults.standard.getApiKey()
        guard let baseUrl = self.baseUrl else {
            print("Invalid base url.")
            return
        }
        guard let url = URL(string: "\(baseUrl)?APPID=\(apiKey)&id=\(endpoint.rawValue)") else { return }

        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            if let data = response.data {
                completion?(data, nil)
            }
        }
    }
}
