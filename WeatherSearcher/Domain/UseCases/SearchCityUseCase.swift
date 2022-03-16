//
//  SearchCityUseCase.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import Resolver

protocol SearchCityUseCaseProtocol {
    func searchCity(city: String, success: @escaping (CitiesEntity) -> Void, error: @escaping () -> Void)
}

struct DefaultSearchCityUseCase: SearchCityUseCaseProtocol {
    
    @Injected
    private var citiesRepository: CitiesRepositoryProtocols
    
    func searchCity(city: String, success: @escaping (CitiesEntity) -> Void, error: @escaping () -> Void) {
        citiesRepository.getCities(city: city, success: { cities in
            success(cities)
        }, error: {
            error()
        })
    }
}
