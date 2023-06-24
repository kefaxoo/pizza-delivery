//
//  PizzeriaResponseModel.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 22.06.23.
//

import Foundation
import ObjectMapper

final class PizzeriaResponseModel: Mappable {
    private(set) var id = "" // Pizzeria id for dodo backend | 00000003-0000-0000-0000-000000000000
    private(set) var address = "" // Pizzeria address | Минск, проспект Дзержинского, 126
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id      <- map["id"]
        address <- map["address"]
    }
}
