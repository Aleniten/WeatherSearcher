//
//  CityDetailsDTO.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import ObjectMapper

class CityDetailsDTO: Mappable {
    var consolidatedWeather: [ConsolidatedWeatherDTO]?
    var lattLong: String?
    var locationType: String?
    var parent: CityDTO?
    var sunRise: String?
    var sunSet: String?
    var time: String?
    var timezone: String?
    var timeZoneName: String?
    var title: String?
    var woeid: Int?
    
    required init?(map: Map) {}

     func mapping(map: Map) {
         consolidatedWeather <- map["consolidated_weather"]
         lattLong <- map["latt_long"]
         locationType <- map["location_type"]
         parent <- map["parent"]
         sunRise <- map["sun_rise"]
         sunSet <- map["sun_set"]
         time <- map["time"]
         timezone <- map["timezone"]
         timeZoneName <- map["timezone_name"]
         title <- map["title"]
         woeid <- map["woeid"]
       }
    
    func toDomain() -> CityDetailsEntity {
        return .init(consolidatedWeather: self.consolidateWeatherForDomain(),
                     lattLong: self.lattLong,
                     locationType: self.locationType,
                     parent: self.parent?.toDomain(),
                     sunRise: self.sunRise,
                     sunSet: self.sunSet,
                     time: self.time,
                     timezone: self.timezone,
                     timeZoneName: self.timeZoneName,
                     title: self.title,
                     woeid: self.woeid)
    }
    
    func consolidateWeatherForDomain() -> [ConsolidatedWeather] {
        var consolidateArray: [ConsolidatedWeather] = []
        if let consolidatedWeatherNotNil = self.consolidatedWeather {
            for consolidateWeatherDTO in consolidatedWeatherNotNil {
                consolidateArray.append(consolidateWeatherDTO.toDomain())
            }
        }
        return consolidateArray
    }
}
