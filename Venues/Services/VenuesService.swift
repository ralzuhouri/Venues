//
//  VenuesService.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 02/12/2022.
//

import Foundation
import Alamofire

enum VenuePhotoQueryType: String {
    case food, indoor, menu, outdoor
}

fileprivate struct VenuesQueryResult: Codable {
    let results: [Venue]
}

fileprivate enum VenuesQueryPath {
    case searchVenues
    case queryPhotos(String) // venueId
}

class VenuesService {
    private var baseUrl: String {
        return "https://api.foursquare.com/v3/places/"
    }
    
    private var apiKey: String {
        return "fsq3nRvpNsUaeBNKWYHbRAtjwkAn3uz1+HFoo72JV+bV/7w="
    }
    
    private var headers: HTTPHeaders {
        return HTTPHeaders([
            HTTPHeader(name: "Authorization", value: apiKey),
            HTTPHeader(name: "Accept", value: "application/json")
        ])
    }
    
    private func path(for queryPath: VenuesQueryPath) -> String {
        switch queryPath {
        case .searchVenues:
            return baseUrl + "search"
        case .queryPhotos(let venueId):
            return baseUrl + "\(venueId)/photos"
        }
    }
    
    func searchVenues(location: VenueCoordinate,
                      query: String? = nil,
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
                
                if let query = query {
                    parameters["query"] = query
                }
                
                if let limit = limit {
                    parameters["limit"] = limit
                }
                
                if let radius = radius {
                    parameters["radius"] = radius
                }
                
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
    
    func queryVenuePhotos(venueId: String,
                          type: VenuePhotoQueryType? = nil,
                          limit: Int? = nil) async throws -> [VenuePhoto] {
        return try await withCheckedThrowingContinuation { continuation in
            var parameters: [String: Any] = [:]
            
            if let type = type {
                parameters["classifications"] = type.rawValue
            }
            
            if let limit = limit {
                parameters["limit"] = limit
            }
            
            let path = path(for: .queryPhotos(venueId))
            
            AF.request(path, method: .get, parameters: parameters, headers: headers)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decoder = JSONDecoder()
                            let photos = try decoder.decode([VenuePhoto].self, from: data)
                            continuation.resume(returning: photos)
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
