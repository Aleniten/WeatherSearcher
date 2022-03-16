//
//  UserDefaultsRepository.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/15/22.
//

import Foundation

struct UserDefaultsRepository: UserDefaultsRepositoryProtocol {
    
    func saveCities(city: CityEntity, success: @escaping () -> Void, error: @escaping () -> Void) {
        if let obj = UserDefaults.standard.retrieve(object: [CityEntity].self, fromKey: "favorites") {
            var temporaryDecodedCities = obj
            temporaryDecodedCities.append(city)
            UserDefaults.standard.save(customObject: temporaryDecodedCities, inKey: "favorites")
        } else {
            UserDefaults.standard.save(customObject: [city], inKey: "favorites")
        }
        
    }
    
    func getCities(success: @escaping ([CityEntity]) -> Void, error: @escaping () -> Void) {
        if let obj = UserDefaults.standard.retrieve(object: [CityEntity].self, fromKey: "favorites") {
            success(obj)
        }
    }
    
    func deleteCities(city: CityEntity, success: @escaping () -> Void, error: @escaping () -> Void) {
        if let obj = UserDefaults.standard.retrieve(object: [CityEntity].self, fromKey: "favorites") {
            var temporaryDecodedCities = obj
            temporaryDecodedCities = temporaryDecodedCities.filter(){$0.woeid != city.woeid}
            UserDefaults.standard.save(customObject: temporaryDecodedCities, inKey: "favorites")
        }
    }
}
