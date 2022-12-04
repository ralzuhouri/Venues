//
//  Venue.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 02/12/2022.
//

import Foundation

struct Venue: Codable, Identifiable {
    let id: String
    let categories: [VenueCategory]
    let chains: [VenueChain]
    let distance: Int
    let geocodes: VenueGeocodes
    let link: String
    let location: VenueLocation
    let name: String
    let timezone: String
    
    enum CodingKeys: String, CodingKey {
        case id = "fsq_id"
        case categories = "categories"
        case chains = "chains"
        case distance = "distance"
        case geocodes = "geocodes"
        case link = "link"
        case location = "location"
        case name = "name"
        case timezone = "timezone"
    }
    
    static var mock: Venue {
        return Venue(id: "",
                     categories: [],
                     chains: [],
                     distance: 40,
                     geocodes: .mock,
                     link: "http:\\mock.com",
                     location: .mock,
                     name: "Mock",
                     timezone: "")
    }
}
