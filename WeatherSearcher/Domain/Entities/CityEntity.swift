//
//  CityEntity.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import UIKit

class CityEntity: Codable {
    var lattLong: String?
    var locationType: String?
    var title: String?
    var woeid: Int?
    var favorite: Bool?
}
