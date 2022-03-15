//
//  CityDTO.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import ObjectMapper

class CityDTO: Mappable {
    var lattLong: String?
    var locationType: String?
    var title: String?
    var woeid: Int?
    var favorite: Bool?
    
    required init?(map: Map) {}

     func mapping(map: Map) {
          lattLong <- map["latt_long"]
          locationType <- map["location_type"]
          title <- map["title"]
          woeid <- map["woeid"]
       }
    
    func toDomain() -> CityEntity {
        return .init(lattLong: self.lattLong, locationType: self.locationType, title: self.title, woeid: self.woeid, favorite: self.favorite)
    }
}
