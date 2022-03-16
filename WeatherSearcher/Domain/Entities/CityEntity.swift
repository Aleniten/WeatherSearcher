//
//  CityEntity.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import UIKit
// City Entity is values that have the city array when search for name i make class and codable to get woid from UserDefaults
class CityEntity: Codable {
    var lattLong: String?
    var locationType: String?
    var title: String?
    var woeid: Int?
    var favorite: Bool?
}
