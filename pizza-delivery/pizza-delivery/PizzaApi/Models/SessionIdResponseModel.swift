//
//  SessionIdResponseModel.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 22.06.23.
//

import Foundation
import ObjectMapper

final class SessionIdResponseModel: Mappable {
    private(set) var sessionId = "" // Session id for dodo promo backend | A72ifxQAAAAApwEAAAitlGQDAAAAAABHSSBhjVlez-LSuw54UrJmNKFYmF0uymw4CvaxOzcj5g
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        sessionId <- map["session.id"]
    }
}
