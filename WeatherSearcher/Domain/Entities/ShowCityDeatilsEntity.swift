//
//  ShowCityDeatilsEntity.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/15/22.
//

import Foundation

struct ShowCityDetailsEntity {
    var consolidatedWeather: [ConsolidatedWeather]?
    var lattLong: String?
    var locationType: String?
    var temp: Double?
    var maxTemp: Double?
    var minTemp: Double?
    var weatherStateName: String?
    var weatherStateAbbr: String?
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
    var isDayLight: Bool? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let time = time, let sunSet = sunSet, let sunRise = sunRise {
            let actualTime = dateFormatter.date(from: time) ?? Date()
            let sunSetTime = dateFormatter.date(from: sunSet) ?? Date()
            let sunRiseTime = dateFormatter.date(from: sunRise) ?? Date()
            print(dateFormatter.string(from: actualTime))
            print(dateFormatter.string(from: sunSetTime))
            print(dateFormatter.string(from: sunRiseTime))
            if actualTime < sunSetTime && (actualTime > sunRiseTime || actualTime == sunRiseTime) {
                return true
            } else {
                return false
            }
        }
        return true
    }
    
    var conditionName: String {
        switch weatherStateAbbr {
        case "sn":
            return "icons8-snow-96"
        case "sl":
            return "icons8-sleet-96"
        case "h":
            return "icons8-hail-96"
        case "t":
            return "icons8-storm-with-heavy-rain-96"
        case "hr":
            return "icons8-heavy-rain-96"
        case "lr":
            return "icons8-light-rain-96"
        case "s":
            return "icons8-rain-cloud-96"
        case "hc":
            return "icons8-cloud-96"
        case "lc":
            return "icons8-partly-cloudy-day-96"
        case "c":
            return "icons8-sun-96"
        default:
            return "icons8-cloud-96"
        }
    }
}
