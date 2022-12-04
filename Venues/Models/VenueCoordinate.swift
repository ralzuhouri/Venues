//
//  VenueCoordinate.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 02/12/2022.
//

import Foundation

struct VenueCoordinate: Codable {
    let latitude: Double
    let longitude: Double
    
    func compactStringRepresentation() -> String {
        return "\(latitude),\(longitude)"
    }
    
    static var amsterdam: VenueCoordinate {
        VenueCoordinate(latitude: 52.3676, longitude: 4.9041)
    }
    
    static var mock: VenueCoordinate {
        return .amsterdam
    }
}
