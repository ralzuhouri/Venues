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
        let location = VenueCoordinate(latitude: 52.3874, longitude: 4.6462)
        
        let venues = try await sut.searchVenues(location: location,
                                                limit: 10,
                                                openNow: true,
                                                radius: 1000)
        
        XCTAssertEqual(venues.count, 10)
        
        for venue in venues {
            XCTAssertLessThan(venue.distance, 1000)
        }
    }
}
