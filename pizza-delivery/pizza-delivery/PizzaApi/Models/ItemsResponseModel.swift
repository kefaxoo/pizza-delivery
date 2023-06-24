//
//  ItemsResponseModel.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 22.06.23.
//

import Foundation
import ObjectMapper

final class ItemsResponseModel: Mappable {
    private(set) var items = [ItemResponseModel]()
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        items <- map["items"]
    }
}

final class ItemResponseModel: Mappable {
    private(set) var name = "" // name of item | Пицца Пепперони
    private(set) var description = "" // description of item | Томатный соус, колбаски пепперони, увеличенная порция сыра моцарелла
    private(set) var imageLink = "" // item image link | https://dodopizza-a.akamaihd.net/static/Img/Products/e89f44ff8ff24bb0bdfabb30654dd366_584x584.heic
    private var categoryRawValue = -1 // item category // 7
    private(set) lazy var category: CategoryType = {
        return CategoryType(rawValue: categoryRawValue) ?? .anotherItem
    }()
    private var prices = [PriceResponseModel]()
    private(set) lazy var beginPrice: Double = {
        var price = Double.greatestFiniteMagnitude
        prices.forEach { priceModel in
            if priceModel.price < price {
                price = priceModel.price
            }
        }
        
        return price
    }()
    
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        name             <- map["name"]
        description      <- map["description"]
        imageLink        <- map["image.url"]
        categoryRawValue <- map["category"]
        prices           <- map["shoppingItems"]
    }
}

final class PriceResponseModel: Mappable {
    private(set) var price = 0.0 // price of item | 2.9
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        price <- map["price"]
    }
}
