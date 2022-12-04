//
//  DistanceFormatter.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 04/12/2022.
//

import Foundation

class DistanceFormatter {
    static func formatted(distance: Int) -> String {
        // Distance in meters
        if distance > 1000 {
            return String(format: "%0.2f Km", Float(distance) / 1000)
        } else {
            return String(format: "%d Mt", distance)
        }
    }
}
