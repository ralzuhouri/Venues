//
//  CLLocationCoordinate2D.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 04/12/2022.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D {
    init(venueCoordinate: VenueCoordinate) {
        self.init(latitude: venueCoordinate.latitude, longitude: venueCoordinate.longitude)
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D,
                           rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension CLLocationCoordinate2D {
    // Compares two coordinates and returns true is the two coordinates
    // are equal or 'about equal', with a certain tolerance.
    func compare(to other: CLLocationCoordinate2D, tolerance: Double) -> Bool {
        let latitudeDiff = fabs(latitude - other.latitude)
        let longitudeDiff = fabs(longitude - other.longitude)
        
        return latitudeDiff <= tolerance && longitudeDiff <= tolerance
    }
}

extension CLLocationCoordinate2D: CustomStringConvertible {
    public var description: String {
        let latitudeString = String(format: "%0.2f°", latitude)
        let longitudeString = String(format: "%0.2f°", longitude)
        return "\(latitudeString), \(longitudeString)"
    }
}

