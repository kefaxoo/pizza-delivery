//
//  PizzaSettingsManager.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 22.06.23.
//

import Foundation

final class PizzaSettingsManager {
    static let standard = PizzaSettingsManager()
    
    private init() {}
    
    private let userDefaults = UserDefaults.standard
    
    /// Code country in ISO 3166-1
    var countryCode: Int {
        get {
            return userDefaults.value(forKey: #function) as? Int ?? -1
        }
        set {
            userDefaults.setValue(newValue, forKey: #function)
        }
    }
    
    /// Location id for dodo backend
    var locationId: String {
        get {
            return userDefaults.value(forKey: #function) as? String ?? ""
        }
        set {
            userDefaults.setValue(newValue, forKey: #function)
        }
    }
    
    /// Location name for menu VC
    var locationName: String {
        get {
            return userDefaults.value(forKey: #function) as? String ?? ""
        }
        set {
            userDefaults.setValue(newValue, forKey: #function)
        }
    }
    
    /// Pizzeria id for dodo backend
    var pizzeriaId: String {
        get {
            return userDefaults.value(forKey: #function) as? String ?? ""
        }
        set {
            userDefaults.setValue(newValue, forKey: #function)
        }
    }
    
    /// Sdk key for dodo promo
    var sdkKey: String {
        get {
            return userDefaults.value(forKey: #function) as? String ?? ""
        }
        set {
            userDefaults.setValue(newValue, forKey: #function)
        }
    }
    
    /// Session id for dodo promo
    var sessionId: String {
        get {
            return userDefaults.value(forKey: #function) as? String ?? ""
        }
        set {
            userDefaults.setValue(newValue, forKey: #function)
        }
    }
}
