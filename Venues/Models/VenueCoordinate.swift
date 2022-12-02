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
}
