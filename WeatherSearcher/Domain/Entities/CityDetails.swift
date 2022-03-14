//
//  CityDetails.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation

struct CityDetails {
    var consolidatedWeather: [ConsolidatedWeather]?
    var lattLong: String?
    var locationType: String?
    var parent: CityEntity?
    var sunRise: String?
    var SunSet: String?
    var time: String?
    var timezone: String?
    var timeZoneName: String?
    var title: String?
    var woeid: Int?
}

struct ConsolidatedWeather {
    var airPressure: Int?
    var applicableDate: String?
    var created: String?
    var humidity: Int?
    var id: Int?
    var maxTemp: String?
    var minTemp: String?
    var predictability: Int?
    var theTemp: String?
    var visibility: String?
    var weatherStateAbbr: String?
    var weatherStateName: String?
    var windDirection: String?
    var windDirectionCompass: String?
    var windSpeed: String?
}
