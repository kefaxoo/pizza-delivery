//
//  SdkKeyResponseModel.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 22.06.23.
//

import Foundation
import ObjectMapper

final class SdkKeyResponseModel: Mappable {
    private(set) var sdkKey = "" // sdk key for promo | RMNcZ_pwWPOZ8CBV2n0j9hyC0l56VWdl
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        sdkKey <- map["inAppStorySdkKey"]
    }
}
