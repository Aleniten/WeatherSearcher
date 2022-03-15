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
    func getCityDetails(woeid: Int)
    func showCityDetails(cityToShow: CityDetailsEntity)
    var cities: Observable<CitiesEntity?> { get }
    var city: Observable<CityDetailsEntity?> { get }
    var cityToshow: Observable<ShowCityDetailsEntity?> { get set }
    var error: Observable<String?> { get }
}
class SearcherCitiesViewModel: SearcherCitiesViewModelProtocol {
    
    var cities: Observable<CitiesEntity?> = Observable(nil)
    var city: Observable<CityDetailsEntity?> = Observable(nil)
    var cityToshow: Observable<ShowCityDetailsEntity?> = Observable(nil)
    var error: Observable<String?> = Observable(nil)
    
    
    @Injected
    private var searchCityUseCase: SearchCityUseCaseProtocol
    @Injected
    private var getCityDetails: GetCityDetailsUseCaseProtocol
    
    init(){}
    
    func searchCity(city: String) {
        searchCityUseCase.searchCity(city: city) { [weak self] citiesResponse in
            self?.cities.value = citiesResponse
        } error: {
            print("Manejo el error")
        }

    }
    
    func getCityDetails(woeid: Int) {
        getCityDetails.getCityDetails(woeid: woeid) { [weak self] cityDetail in
            self?.city.value = cityDetail
            self?.showCityDetails(cityToShow: cityDetail)
        } error: {
            print("Manejo el error")
        }
    }
    
    func showCityDetails(cityToShow: CityDetailsEntity) {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: date)
        print(dateFormatter.string(from: date))
        var cityDataStore = ShowCityDetailsEntity()
        guard var cityChoosed = city.value else { return }
        guard let days = cityChoosed.consolidatedWeather else { return }
        print("DTO days \(days.count)")
        for day in days {
            if day.applicableDate == currentDate {
                cityDataStore.applicableDate = day.applicableDate
                cityDataStore.temp = day.theTemp
                cityDataStore.maxTemp = day.maxTemp
                cityDataStore.minTemp = day.minTemp
                cityDataStore.weatherStateName = day.weatherStateName
                cityDataStore.humidity = day.humidity
                cityDataStore.windSpeed = day.windSpeed
                cityChoosed.consolidatedWeather?.removeAll{$0.applicableDate == currentDate }
            }
            cityDataStore.consolidatedWeather = cityChoosed.consolidatedWeather
            cityDataStore.woeid = cityChoosed.woeid
            cityDataStore.title = cityChoosed.title
            cityDataStore.sunSet = cityChoosed.sunSet
            cityDataStore.parent = cityChoosed.parent
            cityDataStore.sunRise = cityChoosed.sunRise
            cityDataStore.time = cityChoosed.time
            self.cityToshow.value = cityDataStore
            
        }
    }
}

