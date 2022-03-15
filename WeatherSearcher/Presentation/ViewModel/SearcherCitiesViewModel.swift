//
//  SearcherCitiesViewModel.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import Bond
import ReactiveKit
import Resolver

protocol SearcherCitiesViewModelProtocol {
    func searchCity(city: String)
    var city: Observable<CitiesEntity?> { get }
    var error: Observable<String?> { get }
}
class SearcherCitiesViewModel: SearcherCitiesViewModelProtocol {
    var city: Observable<CitiesEntity?> = Observable(nil)
    
    var error: Observable<String?> = Observable(nil)
    
    
    @Injected
    private var searchCityUseCase: SearchCityUseCaseProtocol
    
    init(){}
    
    func searchCity(city: String) {
        searchCityUseCase.searchCity(city: city) { [weak self] citiesResponse in
            self?.city.value = citiesResponse
        } error: {
            print("Manejo el error")
        }

    }
}
