//
//  MenuPresenter.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 23.06.23.
//

import Foundation

final class MenuPresenter {
    private(set) var items = [ItemModel]()
    private(set) var categories: [CategoryType] = CategoryType.allCases.reversed()
    private(set) var promo = [PromoModel]()
    
    weak private var delegate: MenuPresenterDelegate?
    
    init(delegate: MenuPresenterDelegate){
        self.delegate = delegate
        if NetworkMonitor.shared.isNetworkAvailable() {
            PizzaProvider.standard.getItems { items in
                items.sorted(by: { firstObj, secondObj in
                    return firstObj.category.rawValue > secondObj.category.rawValue
                }).forEach { item in
                    self.items.append(ItemModel(item: item))
                }
                
                self.delegate?.reloadData()
                RealmManager<ItemLibraryModel>().read().forEach { item in
                    RealmManager<ItemLibraryModel>().delete(object: item)
                }
                
                self.items.forEach { item in
                    RealmManager<ItemLibraryModel>().write(object: ItemLibraryModel(item: item))
                }
            }
            
            PizzaProvider.standard.getSdkKey {
                PizzaProvider.standard.getSessionId {
                    PizzaProvider.standard.getPromo { promos in
                        promos.forEach { promo in
                            self.promo.append(PromoModel(promo: promo))
                        }
                        
                        self.delegate?.reloadData()
                        RealmManager<PromoLibraryModel>().read().forEach { promo in
                            RealmManager<PromoLibraryModel>().delete(object: promo)
                        }
                        
                        self.promo.forEach { promo in
                            RealmManager<PromoLibraryModel>().write(object: PromoLibraryModel(promo: promo))
                        }
                    }
                }
            }
        } else {
            RealmManager<ItemLibraryModel>().read().forEach { item in
                self.items.append(ItemModel(item: item))
            }
            
            RealmManager<PromoLibraryModel>().read().forEach { promo in
                self.promo.append(PromoModel(promo: promo))
            }
        }
    }
    
    func clearData() {
        PizzaSettingsManager.standard.locationName = ""
        PizzaSettingsManager.standard.pizzeriaId = ""
        PizzaSettingsManager.standard.locationId = ""
        PizzaSettingsManager.standard.countryCode = -1
        PizzaSettingsManager.standard.sdkKey = ""
        PizzaSettingsManager.standard.sessionId = ""
        RealmManager<ItemLibraryModel>().read().forEach { item in
            RealmManager<ItemLibraryModel>().delete(object: item)
        }
        
        RealmManager<PromoLibraryModel>().read().forEach { promo in
            RealmManager<PromoLibraryModel>().delete(object: promo)
        }
    }
}

protocol MenuPresenterDelegate: AnyObject {
    func reloadData()
}
