//
//  SaveFavoritesUseCase.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/15/22.
//

import Foundation
import Resolver

protocol SaveFavoritesUseCaseProtocols {
    func saveCities(city: CityEntity, success: @escaping () -> Void, error: @escaping () -> Void)
}

struct DefaultSaveFavoritesUseCase: SaveFavoritesUseCaseProtocols {
    
    @Injected
    private var userDefaultsRepository: UserDefaultsRepositoryProtocol
    
    func saveCities(city: CityEntity, success: @escaping () -> Void, error: @escaping () -> Void) {
        userDefaultsRepository.saveCities(city: city) {
                success()
            } error: {
                error()
            }
    }
   
}
