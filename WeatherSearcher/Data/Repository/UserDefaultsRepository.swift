//
//  UserDefaultsRepository.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/15/22.
//

import Foundation

struct UserDefaultsRepository: UserDefaultsRepositoryProtocol {
    
    let userDefaults = UserDefaults()
    
    func saveCities(city: CityEntity, success: @escaping () -> Void, error: @escaping () -> Void) {
     
//        if let value = UserDefaults.standard.data(forKey: "favorites") {
//            guard let array = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(value) as? [CityEntity] else {
//                        fatalError("loadWidgetDataArray - Can't get Array")
//                    }
//            var arrayTemporary = NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(value) as? [CityEntity]
//            arrayTemporary.append(city)
//            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: arrayTemporary)
//            userDefaults.set(encodedData, forKey: "favorites")
//          //  userDefaults.setValue(arrayTemporary, forKey: "favorites")
//        } else {
//            userDefaults.set([city], forKey: "favorites")
////            userDefaults.setValue([city], forKey: "favorites")
//        }
    }
    
    func getCities(success: @escaping ([CityEntity]) -> Void, error: @escaping () -> Void) {
        
//        if let value = userDefaults.data(forKey: "favorites") {
//            var arrayTemporary = NSKeyedUnarchiver.unarchiveObject(with: value) as! [CityEntity]
//            success(arrayTemporary)
//        }
        
    }
    
    func deleteCities(city: CityEntity, success: @escaping () -> Void, error: @escaping () -> Void) {
//        if let value = userDefaults.data(forKey: "favorites") {
//            var arrayTemporary = NSKeyedUnarchiver.unarchiveObject(with: value) as! [CityEntity]
//            arrayTemporary = arrayTemporary.filter(){$0.woeid != city.woeid}
//            userDefaults.set(arrayTemporary, forKey: "favorites")
////            userDefaults.setValue(arrayTemporary, forKey: "favorites")
//        }
    }
    
    
}
