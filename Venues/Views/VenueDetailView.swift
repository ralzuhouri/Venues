//
//  VenueDetailView.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 04/12/2022.
//

import SwiftUI

struct VenueDetailView: View {
    let service = VenuesService()
    
    @State var venue: Venue
    @State var photos: [VenuePhoto] = []
    @State var isLoadingPhotos: Bool = false
    
    init(venue: Venue) {
        _venue = State(initialValue: venue)
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                if isLoadingPhotos {
                    ProgressView()
                } else {
                    ForEach(photos) { photo in
                        VenuePhotoView(venuePhoto: photo, size: .original)
                    }
                }
            }
        }
        .onAppear {
            Task {
                isLoadingPhotos = true
                photos = try await service.queryVenuePhotos(venueId: venue.id,
                                                            limit: 5)
                isLoadingPhotos = false
            }
        }
    }
}

struct VenueDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VenueDetailView(venue: .mock)
    }
}
