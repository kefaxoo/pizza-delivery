//
//  ItemLibraryModel.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 24.06.23.
//

import Foundation
import RealmSwift

final class ItemLibraryModel: Object {
    @Persisted var name            : String
    @Persisted var itemDescription : String
    @Persisted var categoryRawValue: Int
    @Persisted var beginPrice      : Double
    
    convenience init(item: ItemModel) {
        self.init()
        self.name = item.name
        self.itemDescription = item.description
        self.categoryRawValue = item.categoryRawValue
        self.beginPrice = item.beginPrice
    }
}
