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
    func showCityDetails(cityToShow: CityDetailsEntity,_ isFavorite: Bool)
    func saveCities(city: CityEntity)
    func deleteCities(city: CityEntity)
    func getCities()
    func populateTableViewWithFavoritesInSearch()
    var cities: Observable<CitiesEntity?> { get }
    var city: Observable<CityDetailsEntity?> { get }
    var cityToshow: Observable<ShowCityDetailsEntity?> { get set }
    var error: Observable<String?> { get }
}
class SearcherCitiesViewModel: SearcherCitiesViewModelProtocol {
    
    var cities: Observable<CitiesEntity?> = Observable(nil)
    private var citiesWithFavorites: CitiesEntity = CitiesEntity.init()
    var city: Observable<CityDetailsEntity?> = Observable(nil)
    var cityToshow: Observable<ShowCityDetailsEntity?> = Observable(nil)
    var error: Observable<String?> = Observable(nil)
    
    
    @Injected
    private var searchCityUseCase: SearchCityUseCaseProtocol
    @Injected
    private var getCityDetails: GetCityDetailsUseCaseProtocol
    @Injected
    private var saveCityUseCase: SaveFavoritesUseCaseProtocols
    @Injected
    private var deleteCityUseCase: DeleteFavoritesUseCaseProtocols
    @Injected
    private var getCitiesUseCase: GetFavoritesUseCaseProtocols
    
    init(){}
    
    func searchCity(city: String) {
        var temporaryCitiesFromBackend = CitiesEntity.init()
        searchCityUseCase.searchCity(city: city) { [weak self] citiesResponse in
            temporaryCitiesFromBackend = citiesResponse
            self?.populateTableViewWithFavoritesInSearch()
            if let cities = self?.citiesWithFavorites.cities {
                let woeids = cities.map { $0.woeid }
                    if let tempCitiesFromBack = temporaryCitiesFromBackend.cities {
                        for city in tempCitiesFromBack {
                            if woeids.contains(city.woeid){
                                city.favorite = true
                            }
                        }
                        temporaryCitiesFromBackend.cities = tempCitiesFromBack
                        self?.cities.value = temporaryCitiesFromBackend
                    } else {
                        self?.cities.value = citiesResponse
                    }
            } else {
                self?.cities.value = citiesResponse
            }
            
        } error: {
            print("Manage Error")
        }
    }
    
    func getCityDetails(woeid: Int) {
        getCityDetails.getCityDetails(woeid: woeid) { [weak self] cityDetail in
            self?.populateTableViewWithFavoritesInSearch()
            if let cities = self?.citiesWithFavorites.cities {
                let woeids = cities.map { $0.woeid }
                if woeids.contains(woeid) {
                    self?.city.value = cityDetail
                    self?.showCityDetails(cityToShow: cityDetail, true)
                } else {
                    self?.city.value = cityDetail
                    self?.showCityDetails(cityToShow: cityDetail, false)
                }
            } else {
                self?.city.value = cityDetail
                self?.showCityDetails(cityToShow: cityDetail, false)
            }
            

        } error: {
            print("Manage Error")
        }
    }
    
    func showCityDetails(cityToShow: CityDetailsEntity,_ isFavorite: Bool) {
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
                cityDataStore.weatherStateAbbr = day.weatherStateAbbr
                cityChoosed.consolidatedWeather?.removeAll{$0.applicableDate == currentDate }
            }
            cityDataStore.favorite = isFavorite
            cityDataStore.locationType = cityChoosed.locationType
            cityDataStore.lattLong = cityChoosed.lattLong
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
    
    func saveCities(city: CityEntity) {
        saveCityUseCase.saveCities(city: city) {
            print("Manage Success")
        } error: {
            print("Manage Error")
        }
    }
    
    func deleteCities(city: CityEntity) {
        deleteCityUseCase.deleteCities(city: city) {
            print("Manage Success")
        } error: {
            print("Manage Error")
        }
    }
    
    func getCities() {
        getCitiesUseCase.getCities(success: { cities in
            var citiesDataStore = CitiesEntity()
            citiesDataStore.cities = cities
            self.cities.value = citiesDataStore
        }, error: {
            print("Manage Error")
        })
    }
    
    func populateTableViewWithFavoritesInSearch() {
        getCitiesUseCase.getCities(success: { cities in
            var citiesDataStore = CitiesEntity()
            citiesDataStore.cities = cities
            self.citiesWithFavorites = citiesDataStore
        }, error: {
            print("Manage Error")
        })
    }
}

