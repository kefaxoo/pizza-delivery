//
//  PizzaApi.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 22.06.23.
//

import Foundation
import Moya

enum PizzaApi {
    case getCountries
    case getLocations
    case getPizzerias
    case getMenu
    case getSdkKey
    case getSessionId
    case getPromo
}

extension PizzaApi: TargetType {
    var baseURL: URL {
        switch self {
            case .getSessionId, .getPromo:
                return URL(string: "https://api.inappstory.ru/v2")!
            default:
                return URL(string: "https://mapi.dodopizza.ru/api")!
        }
    }
    
    var path: String {
        switch self {
            case .getCountries:
                return "/v2/countries"
            case .getLocations:
                return "/v3/localities"
            case .getPizzerias:
                return "/v1/Pizzeria"
            case .getMenu:
                return "/v3/menu/restaurant/\(PizzaSettingsManager.standard.countryCode)/\(PizzaSettingsManager.standard.pizzeriaId)"
            case .getSdkKey:
                return "/v1/stories/sdkkey"
            case .getSessionId:
                return "/session/open"
            case .getPromo:
                return "/feed/default"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getSessionId:
                return .post
            default:
                return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Moya.Task {
        switch self {
            case .getSessionId:
                let sessionIdData = SessionIdData()
                return .requestJSONEncodable(sessionIdData)
            case .getPromo:
                var parameters = [String: Any]()
                parameters["tags"] = "not-authorized%2Cru-RU%2C%D0%BC%D0%B8%D0%BD%D1%81%D0%BA_restaurant%2C%D0%BC%D0%B8%D0%BD%D1%81%D0%BA-12_restaurant%2Crestaurant"
                return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            case .getPizzerias:
                var parameters = [String: Any]()
                parameters["LocalityId"] = PizzaSettingsManager.standard.locationId
                return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            default:
                return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var headers = [String: String]()
        headers["LanguageCode"] = "ru"
        switch self {
            case .getLocations, .getPizzerias, .getMenu, .getSdkKey:
                headers["CountryCode"] = "\(PizzaSettingsManager.standard.countryCode)"
            case .getSessionId:
                headers.removeAll()
                headers["Authorization"] = "Bearer \(PizzaSettingsManager.standard.sdkKey)"
            case .getPromo:
                headers.removeAll()
                headers["Authorization"] = "Bearer \(PizzaSettingsManager.standard.sdkKey)"
                headers["auth-session-id"] = PizzaSettingsManager.standard.sessionId
            default:
                break
        }
        
        return headers
    }
}

fileprivate struct SessionIdData: Codable {
    let platform = "ios"
    let deviceId = "2FD3A90A-2FA4-4DC0-8694-A9A6537ECAE0"
    
    enum CodingKeys: String, CodingKey {
        case platform = "platform"
        case deviceId = "device_id"
    }
}
