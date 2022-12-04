//
//  VenuesListView.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 02/12/2022.
//

import SwiftUI

struct VenuesListView: View {
    @StateObject var viewModel = VenuesListViewModel()
    
    var body: some View {
        ScrollView {
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
            viewModel.searchVenues(location: .mock)
        }
    }
}

struct VenuesListView_Previews: PreviewProvider {
    static var previews: some View {
        VenuesListView()
    }
}
