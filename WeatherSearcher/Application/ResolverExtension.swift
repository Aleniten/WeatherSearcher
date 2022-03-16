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
        // Extensions For injections
        register { DefaultSearchCityUseCase()}.implements(SearchCityUseCaseProtocol.self)
        register { DefaultGetCityDetailsUseCase()}.implements(GetCityDetailsUseCaseProtocol.self)
        register { SearcherCitiesViewModel()}.implements(SearcherCitiesViewModelProtocol.self)
        register { DefaultWeatherRepository()}.implements(CitiesRepositoryProtocols.self)
        register { UserDefaultsRepository()}.implements(UserDefaultsRepositoryProtocol.self)
        register { DefaultSaveFavoritesUseCase()}.implements(SaveFavoritesUseCaseProtocols.self)
        register { DefaultDeleteFavoritesUseCase()}.implements(DeleteFavoritesUseCaseProtocols.self)
        register { DefaultGetFavoritesUseCase()}.implements(GetFavoritesUseCaseProtocols.self)

    }
}
