//
//  LocationsPresenter.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 23.06.23.
//

import Foundation

final class LocationsPresenter {
    private(set) var locations = [LocationResponseModel]()
    
    weak private var delegate: LocationsPresenterDelegate?
    
    init(delegate: LocationsPresenterDelegate) {
        self.delegate = delegate
        PizzaProvider.standard.getLocations { locations in
            self.locations = locations.sorted(by: { firstObj, secondObj in
                return firstObj.order < secondObj.order
            })
            
            self.delegate?.reloadData()
        }
    }
    
    func setLocation(index: Int) {
        PizzaSettingsManager.standard.locationId = locations[index].id
        PizzaSettingsManager.standard.locationName = locations[index].name
    }
}

protocol LocationsPresenterDelegate: AnyObject {
    func reloadData()
}
