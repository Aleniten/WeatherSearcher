//
//  SearchCityUseCase.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import Resolver

protocol SearchCityUseCaseProtocol {
    func searchCity(city: String, completion: (CitiesEntity?) -> Void?)
}

struct DefaultSearchCityUseCase: SearchCityUseCaseProtocol {
    
    @Injected
    private var citiesRepository: CitiesRepositoryProtocols
    
    func searchCity(city: String, completion: (CitiesEntity?) -> Void?) {
        citiesRepository.getCities(city: city, completion: { cities in
            completion(cities)
        })
    }
}
