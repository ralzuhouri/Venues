//
//  VenuesListView.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 02/12/2022.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

// MARK: - View
struct VenuesListView: View {
    @StateObject var locationManager = LocationManager(defaultCoordinate: CLLocationCoordinate2D(venueCoordinate: .amsterdam))
    @StateObject var viewModel = VenuesListViewModel()
    
    @State private var isUsingDefaultLocation: Bool = true
    
    var body: some View {
        ScrollView {
            HStack {
                if isUsingDefaultLocation {
                    Text("Amsterdam")
                        .font(.system(size: 16, weight: .medium))
                } else {
                    Text(locationManager.coordinate.description)
                        .font(.system(size: 16, weight: .medium))
                }
                
                LocationButton {
                    locationManager.requestLocation()
                }
                .frame(width: 32, height: 32)
                .symbolVariant(.circle)
                .labelStyle(.iconOnly)
                .cornerRadius(45)
                .padding(.leading, 16)
                
                Spacer()
                
                Button("Search") {
                    viewModel.searchVenues(location: VenueCoordinate(coordinate: locationManager.coordinate), limit: 20)
                }
            }
            .padding(.horizontal, 16)
            
            if viewModel.isLoading {
                ProgressView()
                    .foregroundColor(.gray)
                    .padding(.top, 16)
            } else if viewModel.didEncounterError,
                        let errorDescription = viewModel.errorDescription {
                Text(errorDescription)
                    .foregroundColor(.red)
                    .padding(.top, 16)
            } else if let venues = viewModel.venues {
                LazyVStack {
                    ForEach(venues) { venue in
                        VenueItemView(venue: venue)
                    }
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 8)
            }
        }
        .navigationTitle("Venues")
        .onAppear {
            locationManager.requestAuthorization()
            viewModel.searchVenues(location: .amsterdam, limit: 20)
        }
        .onChange(of: locationManager.coordinate) { newCoordinate in
            isUsingDefaultLocation = false
            viewModel.searchVenues(location: VenueCoordinate(coordinate: newCoordinate), limit: 20)
        }
    }
}

// MARK: - Previews
struct VenuesListView_Previews: PreviewProvider {
    static var previews: some View {
        VenuesListView()
    }
}
