//
//  CityDetails.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation

struct CityDetailsEntity {
    var consolidatedWeather: [ConsolidatedWeather]?
    var lattLong: String?
    var locationType: String?
    var parent: CityEntity?
    var sunRise: String?
    var sunSet: String?
    var time: String?
    var timezone: String?
    var timeZoneName: String?
    var title: String?
    var woeid: Int?
    
}

struct ConsolidatedWeather {
    var airPressure: Double?
    var applicableDate: String?
    var created: String?
    var humidity: Int?
    var id: Int?
    var maxTemp: Double?
    var minTemp: Double?
    var predictability: Int?
    var theTemp: Double?
    var visibility: Double?
    var weatherStateAbbr: String?
    var weatherStateName: String?
    var windDirection: Double?
    var windDirectionCompass: String?
    var windSpeed: Double?
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
