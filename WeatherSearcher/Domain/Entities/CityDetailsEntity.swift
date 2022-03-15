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
        return "cloud.bolt"
    }
}
