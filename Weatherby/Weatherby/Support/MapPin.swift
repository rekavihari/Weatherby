//
//  Artwork.swift
//  Weatherby
//
//  Created by Reka Vihari on 2019. 02. 10..
//  Copyright © 2019. Reka Vihari. All rights reserved.
//

import MapKit

class MapPin: NSObject, MKAnnotation {
    let title: String?
    let weatherName: String
    let coordinate: CLLocationCoordinate2D

    init(title: String, weatherName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.weatherName = weatherName
        self.coordinate = coordinate

        super.init()
    }

    var subtitle: String? {
        return weatherName
    }
}

