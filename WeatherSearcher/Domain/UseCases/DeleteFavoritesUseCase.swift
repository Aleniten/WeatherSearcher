//
//  DeleteFavoritesUseCase.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/15/22.
//

import Foundation
import Resolver
// Protocol for search city use case from UserDefaults
protocol DeleteFavoritesUseCaseProtocols {
    func deleteCities(city: CityEntity, success: @escaping () -> Void, error: @escaping () -> Void)
}

struct DefaultDeleteFavoritesUseCase: DeleteFavoritesUseCaseProtocols {
    
    @Injected
    private var userDefaultsRepository: UserDefaultsRepositoryProtocol
    
    func deleteCities(city: CityEntity, success: @escaping () -> Void, error: @escaping () -> Void) {
        userDefaultsRepository.deleteCities(city: city) {
               success()
            } error: {
                error()
            }
    }
   
}
