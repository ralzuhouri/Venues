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
    @State private var searchText: String = ""
    
    var body: some View {
        ScrollView {
            HStack {
                if isUsingDefaultLocation {
                    Text("Amsterdam")
                        .font(AppFonts.regularMedium)
                } else {
                    Text(locationManager.coordinate.description)
                        .font(AppFonts.regularMedium)
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
                
                Button {
                    searchVenues(coordinate: locationManager.coordinate)
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .font(AppFonts.big)
                }
            }
            .padding(.horizontal, 16)
            
            if locationManager.authorizationError {
                Text("Please enable location services in system settings")
                    .foregroundColor(.red)
                    .font(AppFonts.regularMedium)
            }
            
            if viewModel.isLoading {
                ProgressView()
                    .foregroundColor(.gray)
                    .padding(.top, 16)
            } else if viewModel.didEncounterError,
                        let errorDescription = viewModel.errorDescription {
                Text(errorDescription)
                    .foregroundColor(.red)
                    .font(AppFonts.regularMedium)
                    .padding(.top, 16)
            } else if let venues = viewModel.venues {
                if venues.isEmpty {
                    Text("No Venues Found")
                        .foregroundColor(.red)
                        .font(AppFonts.regularMedium)
                        .padding(.top, 16)
                } else {
                    LazyVStack {
                        ForEach(venues) { venue in
                            VenueItemView(venue: venue)
                        }
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 8)
                }
            }
        }
        .navigationTitle("Venues")
        .onAppear {
            locationManager.requestAuthorization()
            searchVenues(coordinate: .amsterdam)
        }
        .onChange(of: locationManager.coordinate) { newCoordinate in
            isUsingDefaultLocation = false
            searchVenues(coordinate: newCoordinate)
        }
        .onChange(of: searchText) { _ in
            searchVenues(coordinate: locationManager.coordinate)
        }
        .searchable(text: $searchText, prompt: "Search any place")
    }
}

// MARK: - Queries
private extension VenuesListView {
    func searchVenues(coordinate: CLLocationCoordinate2D) {
        searchVenues(coordinate: VenueCoordinate(coordinate: coordinate))
    }
    
    func searchVenues(coordinate: VenueCoordinate) {
        viewModel.searchVenues(location: coordinate, query: searchText, limit: 20)
    }
}

// MARK: - Previews
struct VenuesListView_Previews: PreviewProvider {
    static var previews: some View {
        VenuesListView()
    }
}
