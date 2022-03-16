//
//  ConsolidatedWeatherDTO.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import ObjectMapper

class ConsolidatedWeatherDTO: Mappable {
    // Data Object
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
    
    required init?(map: Map) {}

     func mapping(map: Map) {
         airPressure <- map["air_pressure"]
         applicableDate <- map["applicable_date"]
         created <- map["created"]
         humidity <- map["humidity"]
         id <- map["id"]
         maxTemp <- map["max_temp"]
         minTemp <- map["min_temp"]
         predictability <- map["predictability"]
         theTemp <- map["the_temp"]
         visibility <- map["visibility"]
         weatherStateAbbr <- map["weather_state_abbr"]
         weatherStateName <- map["weather_state_name"]
         windDirection <- map["wind_direction"]
         windDirectionCompass <- map["wind_direction_compass"]
         windSpeed <- map["wind_speed"]
       }
    
    func toDomain() -> ConsolidatedWeather {
        return .init(airPressure: self.airPressure, applicableDate: self.applicableDate, created: self.created, humidity: self.humidity, id: self.id, maxTemp: self.maxTemp, minTemp: self.minTemp, predictability: self.predictability, theTemp: self.theTemp, visibility: self.visibility, weatherStateAbbr: self.weatherStateAbbr, weatherStateName: self.weatherStateName, windDirection: self.windDirection, windDirectionCompass: self.windDirectionCompass, windSpeed: self.windSpeed)
    }
}
