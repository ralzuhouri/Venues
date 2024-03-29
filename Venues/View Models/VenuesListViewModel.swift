//
//  VenuesListViewModel.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 02/12/2022.
//

import Foundation

@MainActor class VenuesListViewModel: ObservableObject {
    @Published var venues: [Venue] = []
    @Published var isLoading: Bool = false
    @Published var didEncounterError: Bool = false
    @Published var errorDescription: String?
    
    private let service = VenuesService()
    
    func searchVenues(location: VenueCoordinate,
                      query: String? = nil,
                      limit: Int? = nil,
                      openNow: Bool = true,
                      radius: Int? = nil) {
        Task {
            isLoading = true
            
            do {
                venues = try await service.searchVenues(location: location,
                                                        query: query,
                                                        limit: limit,
                                                        openNow: openNow,
                                                        radius: radius)
                didEncounterError = false
                isLoading = false
            } catch {
                didEncounterError = true
                errorDescription = error.localizedDescription
                isLoading = false
            }
        }
    }
}
