//
//  Location.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 02/12/2022.
//

import Foundation

struct VenueLocation: Codable {
    let address: String
    let country: String
    let crossStreet: String?
    let formattedAddress: String
    let locality: String
    let neighborhood: [String]?
    let postcode: String
    let region: String
    
    enum CodingKeys: String, CodingKey {
        case address = "address"
        case country = "country"
        case crossStreet = "cross_street"
        case formattedAddress = "formatted_address"
        case locality = "locality"
        case neighborhood = "neighborhood"
        case postcode = "postcode"
        case region = "region"
    }
}
