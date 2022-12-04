//
//  VenueItemView.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 02/12/2022.
//

import SwiftUI

struct VenueItemView: View {
    @State var venue: Venue

    init(venue: Venue) {
        _venue = State(initialValue: venue)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack() {
                Text(venue.name)
                
                Text("\(venue.distance) m")
            }
        }
    }
}

struct VenueItemView_Previews: PreviewProvider {
    static var previews: some View {
        VenueItemView(venue: .mock)
    }
}
