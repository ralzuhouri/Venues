//
//  VenueItemView.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 02/12/2022.
//

import SwiftUI

struct VenueItemView: View {
    let service = VenuesService()
    
    @State var venue: Venue
    @State var photoSize = CGSize(width: 72, height: 72)
    @State var isLoadingPhoto: Bool = true
    @State var photoUrl: URL?
    
    private var placeholderImage: some View {
        return ProgressView()
            .frame(width: photoSize.width, height: photoSize.height)
            .padding(.trailing, 16)
            .padding(.vertical, 4)
    }

    init(venue: Venue) {
        _venue = State(initialValue: venue)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack() {
                VStack(alignment: .leading) {
                    Text(venue.name)
                        .padding(.bottom, 6)
                        .font(.system(size: 18, weight: .heavy))
                    
                    HStack {
                        Text(venue.formattedCategoriesText())
                            .font(.system(size: 12, weight: .light))
                            .padding(.trailing, 8)
                        
                        Text(DistanceFormatter.formatted(distance: venue.distance))
                            .font(.system(size: 12, weight: .light))
                    }
                }
                .padding(.leading, 8)
                
                Spacer()
                
                if let photoUrl = photoUrl {
                    AsyncImage(url: photoUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: photoSize.width, height: photoSize.height)
                            .padding(.trailing, 8)
                            .padding(.vertical, 4)
                        
                    } placeholder: {
                        placeholderImage
                    }
                } else {
                    placeholderImage
                }
            }
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
                
                let size = CGSize(width: min(photoSize.width, CGFloat(photo.width)),
                                  height: min(photoSize.height, CGFloat(photo.height)))
                
                photoUrl = URL(string: photo.photoUrl(size: size))
            }
        }
    }
}

struct VenueItemView_Previews: PreviewProvider {
    static var previews: some View {
        VenueItemView(venue: .mock)
    }
}
