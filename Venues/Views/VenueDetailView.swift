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
        VStack(alignment: .leading) {
            Text(venue.formattedCategoriesText())
                .font(AppFonts.regularLight)
                .padding(.leading, 16)
            
            ScrollView(.horizontal, showsIndicators: true) {
                if isLoadingPhotos {
                    HStack {
                        Spacer()
                        
                        ProgressView()
                        
                        Spacer()
                    }
                    .frame(width: 300, height: 300)
                } else {
                    HStack {
                        ForEach(photos) { photo in
                            VenuePhotoView(venuePhoto: photo, size: .custom(CGSize(width: 300, height: 300)))
                        }
                    }
                    .padding(.leading, 16)
                }
            }
            
            HStack(alignment: .center) {
                Image(systemName: "mappin.and.ellipse")
                    .font(AppFonts.veryBig)
                
                Spacer()
                
                Text(venue.location.formattedAddress)
                    .font(AppFonts.regularLight)
                
                Spacer()
                
                Text(DistanceFormatter.formatted(distance: venue.distance))
                    .font(AppFonts.regularLight)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
            
            Spacer()
        }
        .navigationTitle(venue.name)
        .onAppear {
            Task {
                isLoadingPhotos = true
                photos = try await service.queryVenuePhotos(venueId: venue.id,
                                                            limit: 10)
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
