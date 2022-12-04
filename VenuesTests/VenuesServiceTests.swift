//
//  VenuesServiceTests.swift
//  VenuesTests
//
//  Created by Ramy Al Zuhouri on 02/12/2022.
//

import XCTest
@testable import Venues

final class VenuesServiceTests: XCTestCase {
    let sut = VenuesService()

    func testSearchPlaces() async throws {
        let location: VenueCoordinate = .mock
        
        let venues = try await sut.searchVenues(location: location,
                                                limit: 10,
                                                openNow: true,
                                                radius: 1000)
        
        XCTAssertEqual(venues.count, 10)
        
        for venue in venues {
            XCTAssertLessThan(venue.distance, 1000)
        }
    }
    
    func testQueryPhotos() async throws {
        let venueId = "4c53dc97fd2ea59329c92329"
        
        let photos = try await sut.queryVenuePhotos(venueId: venueId, limit: 1)
        XCTAssertEqual(photos.count, 1)
    }
}
