//
//  PromoLibraryModel.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 24.06.23.
//

import Foundation
import RealmSwift

final class PromoLibraryModel: Object {
    @Persisted var title : String
    @Persisted var width : Int
    @Persisted var height: Int
    
    convenience init(promo: PromoModel) {
        self.init()
        self.title = promo.title
        self.width = promo.width
        self.height = promo.height
    }
}
