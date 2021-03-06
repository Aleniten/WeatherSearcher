//
//  GetCityDetailsUseCase.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import Resolver
// Protocol for get city use case from api
protocol GetCityDetailsUseCaseProtocol {
    func getCityDetails(woeid: Int, success: @escaping (CityDetailsEntity) -> Void, error: @escaping () -> Void)
}

struct DefaultGetCityDetailsUseCase: GetCityDetailsUseCaseProtocol {
   
    

    @Injected
    private var citiesRepository: CitiesRepositoryProtocols

    func getCityDetails(woeid: Int, success: @escaping (CityDetailsEntity) -> Void, error: @escaping () -> Void) {
        citiesRepository.getCityDetails(woeid: woeid, success: { cityDetail in
            success(cityDetail)
        }, error: {
            error()
        })
    }
}

