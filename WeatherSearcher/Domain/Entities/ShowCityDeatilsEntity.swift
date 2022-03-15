//
//  ShowCityDeatilsEntity.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/15/22.
//

import Foundation

struct ShowCityDetailsEntity {
    var consolidatedWeather: [ConsolidatedWeather]?
    var temp: Double?
    var maxTemp: Double?
    var minTemp: Double?
    var weatherStateName: String?
    var parent: CityEntity?
    var sunRise: String?
    var sunSet: String?
    var time: String?
    var title: String?
    var woeid: Int?
    var applicableDate: String?
    var humidity: Int?
    var windSpeed: Double?
    var favorite: Bool?
    
    var conditionName: String {
        return "cloud.bolt"
//        switch icon {
//        case 200...232:
//            return "cloud.bolt"
//        case 300...321:
//            return "cloud.drizzle"
//        case 500...531:
//            return "cloud.rain"
//        case 600...622:
//            return "cloud.snow"
//        case 701...781:
//            return "cloud.fog"
//        case 800:
//            return "sun.max"
//        case 801...804:
//            return "cloud.bolt"
//        default:
//            return "cloud"
//        }
    }
}
