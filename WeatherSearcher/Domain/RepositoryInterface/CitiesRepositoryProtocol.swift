//
//  CitiesRepositoryProtocol.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation

protocol CitiesRepositoryProtocols {
    func getCities(city: String, completion:(CitiesEntity) -> Void)
    func getCityDetails(woeid: Int, completion:(CityDetails) -> Void)
}
