//
//  VenuePhotoView.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 04/12/2022.
//

import SwiftUI

struct VenuePhotoView: View {
    enum Size {
        case original
        case custom(CGSize)
    }
    
    @State var venuePhoto: VenuePhoto
    @State var size: CGSize
    @State private var photoUrl: URL?
    
    private var placeholderImage: some View {
        return ProgressView()
            .frame(width: size.width, height: size.height)
            .padding(.trailing, 16)
            .padding(.vertical, 4)
    }
    
    init(venuePhoto: VenuePhoto, size: Size, isPlaceholder: Bool = false) {
        _venuePhoto = State(initialValue: venuePhoto)
        
        switch size {
        case .original:
            _size = State(initialValue: CGSize(width: venuePhoto.width, height: venuePhoto.height))
        case .custom(let cgSize):
            _size = State(initialValue: CGSize(width: min(cgSize.width, CGFloat(venuePhoto.width)),
                                               height: min(cgSize.height, CGFloat(venuePhoto.height))))
        }
    }
    
    var body: some View {
        Group {
            if let photoUrl = photoUrl {
                AsyncImage(url: photoUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size.width, height: size.height)
                        .padding(.trailing, 8)
                        .padding(.vertical, 4)
                    
                } placeholder: {
                    placeholderImage
                }
            } else {
                placeholderImage
            }
        }
        .onAppear {
            Task {
                let photoSize = CGSize(width: min(size.width, CGFloat(venuePhoto.width)),
                                       height: min(size.height, CGFloat(venuePhoto.height)))
                
                photoUrl = URL(string: venuePhoto.photoUrl(size: photoSize))
            }
        }
    }
}

struct VenuePhotoView_Previews: PreviewProvider {
    static var previews: some View {
        VenuePhotoView(venuePhoto: .mock,
                       size: .custom(CGSize(width: 300, height: 300)))
    }
}
