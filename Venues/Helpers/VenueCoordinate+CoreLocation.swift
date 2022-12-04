//
//  VenueCoordinate+CoreLocation.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 04/12/2022.
//

import Foundation
import CoreLocation

extension VenueCoordinate {
    init(coordinate: CLLocationCoordinate2D) {
        longitude = coordinate.longitude
        latitude = coordinate.latitude
    }
}
