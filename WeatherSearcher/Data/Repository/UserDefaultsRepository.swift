//
//  UserDefaultsRepository.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/15/22.
//

import Foundation

struct UserDefaultsRepository: UserDefaultsRepositoryProtocol {
    // Repository for UserDefaults
    func saveCities(city: CityEntity, success: @escaping () -> Void, error: @escaping () -> Void) {
        if let obj = UserDefaults.standard.retrieve(object: [CityEntity].self, fromKey: "favorites") {
            var temporaryDecodedCities = obj
            temporaryDecodedCities.append(city)
            UserDefaults.standard.save(customObject: temporaryDecodedCities, inKey: "favorites")
        } else {
            UserDefaults.standard.save(customObject: [city], inKey: "favorites")
        }
        
        if let validationObj = UserDefaults.standard.retrieve(object: [CityEntity].self, fromKey: "favorites") {
            let woeids = validationObj.map { $0.woeid }
            if woeids.contains(city.woeid){
                success()
            } else {
                error()
            }
           
        } else {
            error()
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
        if let validationObj = UserDefaults.standard.retrieve(object: [CityEntity].self, fromKey: "favorites") {
            let woeids = validationObj.map { $0.woeid }
            if woeids.contains(city.woeid){
                error()
            } else {
                success()
            }
        }
    }
}
