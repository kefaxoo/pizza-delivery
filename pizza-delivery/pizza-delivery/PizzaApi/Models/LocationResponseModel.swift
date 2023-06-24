//
//  LocationResponseModel.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 22.06.23.
//

import Foundation
import ObjectMapper

final class LocationResponseModel: Mappable {
    private(set) var id = "" // Location id for dodo backend | 00000001-0000-0000-0000-000000000000
    private(set) var name = "" // Location name | Минск
    private(set) var order = 0 // Location order in list
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        name  <- map["name"]
        order <- map["order"]
    }
}
