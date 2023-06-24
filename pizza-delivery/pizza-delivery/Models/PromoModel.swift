//
//  PromoModel.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 24.06.23.
//

import Foundation

final class PromoModel {
    let title              : String
    private(set) var width : Int = 0
    private(set) var height: Int = 0
    private(set) lazy var imageFilename: String = {
        return "Images/Promos/\(title.toUnixFilename).png"
    }()
    
    var imageLink: String = ""
    
    init(promo: PromoLibraryModel) {
        self.title = promo.title
        self.width = promo.width
        self.height = promo.height
    }
    
    init(promo: StoryResponseModel) {
        self.title = promo.title
        guard let image = promo.images.first else { return }
        
        self.width = image.width
        self.height = image.height
        self.imageLink = image.link
    }
}
