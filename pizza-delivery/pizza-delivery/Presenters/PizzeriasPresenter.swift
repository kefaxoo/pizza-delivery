//
//  PizzeriasPresenter.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 23.06.23.
//

import Foundation

final class PizzeriasPresenter {
    private(set) var pizzerias = [PizzeriaResponseModel]()
    
    weak private var delegate: PizzeriasPresenterDelegate?
    
    init(delegate: PizzeriasPresenterDelegate) {
        self.delegate = delegate
        PizzaProvider.standard.getPizzerias { pizzerias in
            self.pizzerias = pizzerias
            self.delegate?.reloadData()
        }
    }
    
    func setPizzeria(index: Int) {
        PizzaSettingsManager.standard.pizzeriaId = pizzerias[index].id
    }
}

protocol PizzeriasPresenterDelegate: AnyObject {
    func reloadData()
}

