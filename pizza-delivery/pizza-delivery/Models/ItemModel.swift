//
//  ItemModel.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 24.06.23.
//

import Foundation

final class ItemModel {
    let name                      : String
    let description               : String
    let categoryRawValue          : Int
    private(set) lazy var category: CategoryType = {
        return CategoryType(rawValue: categoryRawValue) ?? .pizza
    }()
    
    let beginPrice: Double
    private(set) lazy var imageFilename: String = {
        return "Images/Items/\(name.toUnixFilename).png"
    }()
    
    private(set) var imageLink: String = ""
    
    init(item: ItemLibraryModel) {
        self.name = item.name
        self.description = item.itemDescription
        self.categoryRawValue = item.categoryRawValue
        self.beginPrice = item.beginPrice
    }
    
    init(item: ItemResponseModel) {
        self.name = item.name
        self.description = item.description
        self.categoryRawValue = item.category.rawValue
        self.beginPrice = item.beginPrice
        self.imageLink = item.imageLink
    }
}
