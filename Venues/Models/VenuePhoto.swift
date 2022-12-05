//
//  VenuePhoto.swift
//  Venues
//
//  Created by Ramy Al Zuhouri on 04/12/2022.
//

import Foundation

struct VenuePhoto: Codable, Identifiable {
    let id: String
    let createdAt: String
    let prefix: String
    let suffix: String
    let width: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case prefix = "prefix"
        case suffix = "suffix"
        case width = "width"
        case height = "height"
    }
    
    func photoUrl(size: CGSize? = nil) -> String {
        let sizeComponent: String
        
        if let size = size {
            sizeComponent = "\(Int(size.width))x\(Int(size.width))"
        } else {
            sizeComponent = "original/"
        }
        
        return prefix + sizeComponent + suffix
    }
    
    static var mock: VenuePhoto {
        return VenuePhoto(id: "500d8ccfe4b0ba42c30edea3",
                          createdAt: "2012-07-23T17:41:35.000Z",
                          prefix: "https://fastly.4sqi.net/img/general/",
                          suffix: "/5krE97fP1ZW-6dv5ONknxoQGRpP6OhYgA33IEynbu-M.jpg",
                          width: 612,
                          height: 612)
    }
}
