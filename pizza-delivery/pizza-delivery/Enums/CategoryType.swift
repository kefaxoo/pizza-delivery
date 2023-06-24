//
//  CategoryType.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 22.06.23.
//

import Foundation

enum CategoryType: Int, CaseIterable {
    case pizza = 1
    case drink = 2
    case snack = 3
    case sause = 4
    case anotherItem = 5
    case dessert = 6
    case pizzaPiece = 7
    case combo = 100
    
    var title: String {
        switch self {
            case .pizza:
                return "Pizza"
            case .drink:
                return "Drink"
            case .snack:
                return "Snack"
            case .sause:
                return "Sause"
            case .anotherItem:
                return "Another item"
            case .dessert:
                return "Dessert"
            case .pizzaPiece:
                return "Pizza piece"
            case .combo:
                return "Combo"
        }
    }
}
