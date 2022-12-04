//
//  VenuePhoto.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 04/12/2022.
//

import Foundation

struct VenuePhoto: Codable {
    let id: String
    let createdAt: String
    let prefix: String
    let suffix: String
    let width: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case prefix = "prefix"
        case suffix = "suffix"
        case width = "width"
        case height = "height"
    }
}
