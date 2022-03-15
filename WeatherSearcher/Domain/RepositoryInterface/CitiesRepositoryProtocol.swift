//
//  CitiesRepositoryProtocol.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation

protocol CitiesRepositoryProtocols {
    func getCities(city: String, success: @escaping (CitiesEntity) -> Void, error: @escaping () -> Void)
    func getCityDetails(woeid: Int, success: @escaping (CityDetails) -> Void, error: @escaping () -> Void)
}
