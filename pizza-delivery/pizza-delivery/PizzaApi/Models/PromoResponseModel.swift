//
//  PromoResponseModel.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 22.06.23.
//

import Foundation
import ObjectMapper

final class PromoResponseModel: Mappable {
    private(set) var stories = [StoryResponseModel]()
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        stories <- map["stories"]
    }
}

final class StoryResponseModel: Mappable {
    private(set) var title = ""
    private(set) var images = [StoryImageResponseModel]()
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        title  <- map["title"]
        images <- map["image"]
    }
}

final class StoryImageResponseModel: Mappable {
    private(set) var link = "" // promo image link | https://cs.inappstory.com/story/qzq/bjv/qkh/xwz4onfegj9kxppdmbtd5rj/custom_cover/logo-175x220.webp?v=1687420190
    private(set) var width = 0 // promo image width | 175
    private(set) var height = 0 // promo image height | 220
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        link   <- map["url"]
        width  <- map["width"]
        height <- map["height"]
    }
}
