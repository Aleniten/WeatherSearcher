//
//  UserDefaultsRepositoryProtocol.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/15/22.
//

import Foundation
// Protocol for Repository from UserDefaults
protocol UserDefaultsRepositoryProtocol {
    func saveCities(city: CityEntity, success: @escaping () -> Void, error: @escaping () -> Void)
    func getCities(success: @escaping ([CityEntity]) -> Void, error: @escaping () -> Void)
    func deleteCities(city: CityEntity, success: @escaping () -> Void, error: @escaping () -> Void)
}
