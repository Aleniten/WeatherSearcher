//
//  DeleteFavoritesUseCase.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/15/22.
//

import Foundation
import Resolver

protocol DeleteFavoritesUseCaseProtocols {
    func deleteCities(city: CityEntity, success: @escaping () -> Void, error: @escaping () -> Void)
}

struct DefaultDeleteFavoritesUseCase: DeleteFavoritesUseCaseProtocols {
    
    @Injected
    private var userDefaultsRepository: UserDefaultsRepositoryProtocol
    
    func deleteCities(city: CityEntity, success: @escaping () -> Void, error: @escaping () -> Void) {
        userDefaultsRepository.deleteCities(city: city) {
                print("Succesfully Deleted City")
            } error: {
                print("Error in Deleted City")
            }
    }
   
}
