//
//  VenueGeocode.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 02/12/2022.
//

import Foundation

struct VenueGeocodes: Codable {
    let main: VenueCoordinate
    let roof: VenueCoordinate?
    
    static var mock: VenueGeocodes {
        return VenueGeocodes(main: .mock, roof: .mock)
    }
}
