//
//  VenueCategory.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 02/12/2022.
//

import Foundation

struct VenueCategory: Codable, Identifiable {
    let id: Int
    let name: String
    let icon: VenueIcon
}
