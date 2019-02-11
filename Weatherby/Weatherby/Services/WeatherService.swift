//
//  WeatherService.swift
//  Weatherby
//
//  Created by Reka Vihari on 2019. 02. 10..
//  Copyright © 2019. Reka Vihari. All rights reserved.
//

import Foundation

class WeatherService {

    static let shared = WeatherService()

    private init () {}

    func getWeather(for endpoint: Endpoints, completion: ((WeatherData) -> Void)?) {
        let networkService = NetworkService.shared
        networkService.get(endpoint: endpoint, completion: { response, error in
            var weather: WeatherData
            if let response = response {
                do {
                    weather = try JSONDecoder().decode(WeatherData.self, from: response)
                    completion?(weather)
                } catch {
                    print("A dekodolas sikertelen volt.")
                }
            }
        })
    }
}

