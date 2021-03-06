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
// MARK: - Protocol For ViewModel
protocol SearcherCitiesViewModelProtocol {
    
    func searchCity(city: String)
    func getCityDetails(woeid: Int)
    func showCityDetails(cityToShow: CityDetailsEntity,_ isFavorite: Bool)
    func saveCities(city: CityEntity)
    func deleteCities(city: CityEntity)
    func getCities()
    func populateTableViewWithFavoritesInSearch()
    func restartSearchedValue()
    var cities: Observable<CitiesEntity?> { get }
    var city: Observable<CityDetailsEntity?> { get }
    var citySearched: Observable<Bool?> { get }
    var cityDetailsRequestEncounter: Observable<Bool?> { get }
    var savedFavoritesState: Observable<Bool?> { get }
    var deletedFavoriteState: Observable<Bool?> { get }
    var cityToshow: Observable<ShowCityDetailsEntity?> { get set }
    var error: Observable<String?> { get }
    var citiesFromUserDefault: Observable<CitiesEntity?> { get }
}
// MARK: - ViewModel
class SearcherCitiesViewModel: SearcherCitiesViewModelProtocol {
    // MARK: - ViewModel values
    var cities: Observable<CitiesEntity?> = Observable(nil)
    private var citiesWithFavorites: CitiesEntity = CitiesEntity.init()
    var city: Observable<CityDetailsEntity?> = Observable(nil)
    var cityToshow: Observable<ShowCityDetailsEntity?> = Observable(nil)
    var savedFavoritesState: Observable<Bool?> = Observable(nil)
    var deletedFavoriteState: Observable<Bool?> = Observable(nil)
    var citySearched: Observable<Bool?> = Observable(nil)
    var cityDetailsRequestEncounter: Observable<Bool?> = Observable(nil)
    var error: Observable<String?> = Observable(nil)
    var citiesFromUserDefault: Observable<CitiesEntity?> = Observable(nil)
    
    // MARK: - Injections
    
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
    
    // MARK: - ViewModel function to get cities searched and see if have favorites in SearcherCitiesViewController
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
                    }
            } else {
                self?.cities.value = citiesResponse
            }
            if let tempCities = temporaryCitiesFromBackend.cities {
                if tempCities.isEmpty {
                    self?.cities.value = self?.citiesWithFavorites
                    self?.citySearched.value = true
                } else {
                    self?.cities.value = temporaryCitiesFromBackend
                }
            }
        } error: {
            // In Case we don't found cities
            self.populateTableViewWithFavoritesInSearch()
            self.citySearched.value = true
            if let cities = self.citiesWithFavorites.cities {
                if !cities.isEmpty {
                    self.cities.value = self.citiesWithFavorites
                }
            }
            self.cities.value = nil
        }
    }
    
    // MARK: - ViewModel function to get cities Details it use in both ViewControllers
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
            self.cityToshow.value = nil
            self.cityDetailsRequestEncounter.value = true
        }
    }
    // MARK: - ViewModel function that prepare city Details to show in CityDetailsViewController
    
    func showCityDetails(cityToShow: CityDetailsEntity,_ isFavorite: Bool) {
        // Use Dates components to retrieve the data from today and use in first view of CityDetailsViewController
        let date = Date()
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
    
    // MARK: - ViewModel function to save city From UserDefaults in CityDetailsViewController
    func saveCities(city: CityEntity) {
        saveCityUseCase.saveCities(city: city) {
            self.savedFavoritesState.value = true
        } error: {
            self.savedFavoritesState.value = false
        }
    }
    
    // MARK: - ViewModel function to delete city From UserDefaults in CityDetailsViewController
    func deleteCities(city: CityEntity) {
        deleteCityUseCase.deleteCities(city: city) {
            self.deletedFavoriteState.value = true
        } error: {
            self.deletedFavoriteState.value = false
        }
    }
    // MARK: - ViewModel function to get cities From UserDefaults in CityDetailsViewController
    func getCities() {
        getCitiesUseCase.getCities(success: { cities in
            var citiesDataStore = CitiesEntity()
            citiesDataStore.cities = cities
            self.citiesFromUserDefault.value = citiesDataStore
        }, error: {
            print("Manage Error")
        })
    }
    
    // MARK: - ViewModel function to populate favorites cities to use in both ViewControllers
    func populateTableViewWithFavoritesInSearch() {
        getCitiesUseCase.getCities(success: { cities in
            var citiesDataStore = CitiesEntity()
            citiesDataStore.cities = cities
            self.citiesWithFavorites = citiesDataStore
        }, error: {
            print("Manage Error")
        })
    }
    
    func restartSearchedValue() {
        self.citySearched.value = false
    }
}

