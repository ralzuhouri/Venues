//
//  VenueItemView.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 02/12/2022.
//

import SwiftUI

struct VenueItemView: View {
    @State var venue: Venue
    @State private var venuePhoto: VenuePhoto?
    @State private var photoSize = CGSize(width: 72, height: 72)
    
    private let service = VenuesService()

    init(venue: Venue) {
        _venue = State(initialValue: venue)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack() {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text(venue.name)
                            .font(AppFonts.regularHeavy)
                            .padding(.bottom, 6)
                            .padding(.trailing, 8)
                        
                        NavigationLink(value: venue) {
                            Image(systemName: "info.circle")
                                .font(AppFonts.regularHeavy)
                                .padding(.bottom, 6)
                        }
                    }
                    
                    HStack {
                        Text(venue.formattedCategoriesText())
                            .font(AppFonts.small)
                            .padding(.trailing, 8)
                        
                        Text(DistanceFormatter.formatted(distance: venue.distance))
                            .font(AppFonts.small)
                    }
                }
                .padding(.leading, 8)
                .padding(.bottom, 8)
                
                Spacer()
                
                if let venuePhoto = venuePhoto {
                    VenuePhotoView(venuePhoto: venuePhoto, size: .custom(photoSize))
                } else {
                    VenuePhotoView(venuePhoto: .mock,
                                   size: .custom(photoSize))
                        .redacted(reason: .placeholder)
                }
            }
        }
        .navigationDestination(for: Venue.self) { venue in
            VenueDetailView(venue: venue)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color.gray, lineWidth: 1)
        )
        .onAppear {
            Task {
                let photos = try await service.queryVenuePhotos(venueId: venue.id,
                                                                limit: 1)
                
                guard let photo = photos.first else {
                    return
                }
                
                photoSize = CGSize(width: min(photoSize.width, CGFloat(photo.width)),
                                   height: min(photoSize.height, CGFloat(photo.height)))
                venuePhoto = photo
            }
        }
    }
}

struct VenueItemView_Previews: PreviewProvider {
    static var previews: some View {
        VenueItemView(venue: .mock)
    }
}
