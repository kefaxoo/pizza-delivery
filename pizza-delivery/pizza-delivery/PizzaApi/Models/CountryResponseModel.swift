//
//  CountryResponseModel.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 22.06.23.
//

import Foundation
import ObjectMapper

final class CountryResponseModel: Mappable {
    private(set) var name = "" // Name of country | Belarus
    private var isoName = "" // ISO String code of country | BY
    private(set) lazy var emoji: String = { // Emoji of country | 🇧🇾
        let base: UInt32 = 127397
        var s = ""
        isoName.unicodeScalars.forEach { v in
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        
        return String(s)
    }()
    
    private(set) var code = 0 // ISO Numeric code of country | 112
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        name    <- map["name"]
        isoName <- map["isoName"]
        code    <- map["code"]
    }
}
