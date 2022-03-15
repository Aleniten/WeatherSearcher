//
//  ResolverExtension.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {

        register { DefaultSearchCityUseCase()}.implements(SearchCityUseCaseProtocol.self)
        register { DefaultGetCityDetailsUseCase()}.implements(GetCityDetailsUseCaseProtocol.self)
        register { SearcherCitiesViewModel()}.implements(SearcherCitiesViewModelProtocol.self)
        register { DefaultWeatherRepository()}.implements(CitiesRepositoryProtocols.self)
    }
}
