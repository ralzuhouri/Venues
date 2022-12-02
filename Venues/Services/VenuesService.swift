//
//  VenuesService.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 02/12/2022.
//

import Foundation
import Alamofire

fileprivate struct VenuesQueryResult: Codable {
    let results: [Venue]
}

fileprivate enum VenuesQueryPath {
    case searchVenues
}

class VenuesService {
    private var baseUrl: String {
        return "https://api.foursquare.com/v3/places/"
    }
    
    private var apiKey: String {
        return "fsq3nRvpNsUaeBNKWYHbRAtjwkAn3uz1+HFoo72JV+bV/7w="
    }
    
    private func path(for queryPath: VenuesQueryPath) -> String {
        switch queryPath {
        case .searchVenues:
            return baseUrl + "search"
        }
    }
    
    func searchVenues(location: VenueCoordinate,
                      limit: Int? = nil,
                      openNow: Bool = true,
                      radius: Int? = nil) async throws -> [Venue] {
        return try await withCheckedThrowingContinuation { continuation in
            Task {
                var parameters: [String: Any] = [
                    "ll": location.compactStringRepresentation(),
                    "open_now": openNow.description,
                    "sort": "DISTANCE"
                ]
                
                if let limit = limit {
                    parameters["limit"] = limit
                }
                
                if let radius = radius {
                    parameters["radius"] = radius
                }
                
                let headers = HTTPHeaders([
                    HTTPHeader(name: "Authorization", value: apiKey),
                    HTTPHeader(name: "Accept", value: "application/json")
                ])
                
                let path = path(for: .searchVenues)
                
                AF.request(path, method: .get, parameters: parameters, headers: headers)
                    .responseData { response in
                        switch response.result {
                        case .success(let data):
                            do {
                                let decoder = JSONDecoder()
                                let queryResult = try decoder.decode(VenuesQueryResult.self, from: data)
                                continuation.resume(returning: queryResult.results)
                            } catch {
                                continuation.resume(throwing: error)
                            }
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        }
                    }
            }
        }
    }
}
