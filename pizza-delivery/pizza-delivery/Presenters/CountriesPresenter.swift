//
//  CountriesPresenter.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 22.06.23.
//

import Foundation

final class CountriesPresenter {
    private(set) var countries = [CountryResponseModel]()
    
    weak private var delegate: CountriesPresenterDelegate?
    
    init(delegate: CountriesPresenterDelegate) {
        self.delegate = delegate
        PizzaProvider.standard.getCountries { countries in
            self.countries = countries
            self.delegate?.reloadData()
        }
    }
    
    func setCountry(index: Int) {
        PizzaSettingsManager.standard.countryCode = countries[index].code
    }
}

protocol CountriesPresenterDelegate: AnyObject {
    func reloadData()
}
