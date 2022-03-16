//
//  GetFavoritesUseCase.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/15/22.
//

import Foundation
import Resolver
// Protocol for search city use case from UserDefaults
protocol GetFavoritesUseCaseProtocols {
    func getCities(success: @escaping ([CityEntity]) -> Void, error: @escaping () -> Void)
}

struct DefaultGetFavoritesUseCase: GetFavoritesUseCaseProtocols {
    
    @Injected
    private var userDefaultsRepository: UserDefaultsRepositoryProtocol
    
    func getCities(success: @escaping ([CityEntity]) -> Void, error: @escaping () -> Void) {
        userDefaultsRepository.getCities(success: { cities in
            success(cities)
        }, error: {
            error()
        })
    }
   
}
