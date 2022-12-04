//
//  LocationManager.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 04/12/2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var coordinate: CLLocationCoordinate2D
    
    private let manager = CLLocationManager()

    init(defaultCoordinate: CLLocationCoordinate2D) {
        coordinate = defaultCoordinate
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.first else {
            return
        }
        
        // Using a tolerance of 0.00009°, corresponding to roughly 10 meters
        // allows the new location to be updated only if there is such
        // significant difference.
        guard !newLocation.coordinate.compare(to: coordinate, tolerance: 0.00009) else {
            return
        }
        
        coordinate = newLocation.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
