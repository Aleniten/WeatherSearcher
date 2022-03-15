//
//  GetCityDetailsUseCase.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import Resolver

protocol GetCityDetailsUseCaseProtocol {
    func getCityDetails(woeid: Int, completion: (CityDetails?) -> Void?)
}

struct DefaultGetCityDetailsUseCase: GetCityDetailsUseCaseProtocol {
   
    

    @Injected
    private var citiesRepository: CitiesRepositoryProtocols

    func getCityDetails(woeid: Int, completion: (CityDetails?) -> Void?) {
        citiesRepository.getCityDetails(woeid: woeid, completion: { cityDetails in
            completion(cityDetails)
        })
    }
}

