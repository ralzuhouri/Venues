//
//  LocationManager.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 04/12/2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {
    @Published var coordinate: CLLocationCoordinate2D
    @Published var authorizationError: Bool = false
    
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
        determineErrorStatus()
        
        guard !authorizationError else {
            return
        }
        
        manager.requestLocation()
    }
    
    private func determineErrorStatus() {
        switch manager.authorizationStatus {
        case .notDetermined:
            // Not enabled, but the user can still do it via the location
            // services popup. This doesn't trigger an error
            authorizationError = false
        case .denied, .restricted:
            authorizationError = true
        case .authorizedAlways, .authorizedWhenInUse:
            authorizationError = false
        @unknown default:
            assertionFailure("Unhandled authorization status value")
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
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
