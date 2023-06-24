//
//  PizzaProvider.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 22.06.23.
//

import Foundation
import Moya
import Moya_ObjectMapper

final class PizzaProvider {
    static let standard = PizzaProvider()
    
    private init() {}
    
    private let provider = MoyaProvider<PizzaApi>()
    
    func getCountries(success: @escaping((([CountryResponseModel]) -> ())), failure: ((String) -> ())? = nil) {
        provider.request(.getCountries) { result in
            switch result {
                case .success(let response):
                    guard let countries = try? response.mapArray(CountryResponseModel.self) else {
                        failure?("Map error")
                        return
                    }
                    
                    success(countries)
                case .failure(let error):
                    failure?(error.localizedDescription)
            }
        }
    }
    
    func getLocations(success: @escaping((([LocationResponseModel]) -> ())), failure: ((String) -> ())? = nil) {
        provider.request(.getLocations) { result in
            switch result {
                case .success(let response):
                    guard let locations = try? response.mapArray(LocationResponseModel.self) else {
                        failure?("Map error")
                        return
                    }
                    
                    success(locations)
                case .failure(let error):
                    failure?(error.localizedDescription)
            }
        }
    }
    
    func getPizzerias(success: @escaping(([PizzeriaResponseModel]) -> ()), failure: ((String) -> ())? = nil) {
        provider.request(.getPizzerias) { result in
            switch result {
                case .success(let response):
                    guard let pizzerias = try? response.mapArray(PizzeriaResponseModel.self) else {
                        failure?("Map error")
                        return
                    }
                    
                    success(pizzerias)
                case .failure(let error):
                    failure?(error.localizedDescription)
            }
        }
    }
    
    func getItems(success: @escaping(([ItemResponseModel]) -> ()), failure: ((String) -> ())? = nil) {
        provider.request(.getMenu) { result in
            switch result {
                case .success(let response):
                    guard let items = try? response.mapObject(ItemsResponseModel.self) else {
                        failure?("Map error")
                        return
                    }
                    
                    success(items.items)
                case .failure(let error):
                    failure?(error.localizedDescription)
            }
        }
    }
    
    func getSdkKey(success: @escaping(() -> ())) {
        provider.request(.getSdkKey) { result in
            switch result {
                case .success(let response):
                    guard let sdkKeyObj = try? response.mapObject(SdkKeyResponseModel.self) else { return }
                    
                    PizzaSettingsManager.standard.sdkKey = sdkKeyObj.sdkKey
                    success()
                case .failure:
                    return
            }
        }
    }
    
    func getSessionId(success: @escaping(() -> ())) {
        provider.request(.getSessionId) { result in
            switch result {
                case .success(let response):
                    guard let sessionIdObj = try? response.mapObject(SessionIdResponseModel.self) else { return }
                    
                    PizzaSettingsManager.standard.sessionId = sessionIdObj.sessionId
                    success()
                case .failure:
                    return
            }
        }
    }
    
    func getPromo(success: @escaping(([StoryResponseModel]) -> ())) {
        provider.request(.getPromo) { result in
            switch result {
                case .success(let response):
                    guard let promoObj = try? response.mapObject(PromoResponseModel.self) else { return }
                    
                    success(promoObj.stories)
                case .failure:
                    return
            }
        }
    }
}
