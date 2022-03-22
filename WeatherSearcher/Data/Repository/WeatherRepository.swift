//
//  WeatherRepository.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

struct DefaultWeatherRepository: CitiesRepositoryProtocols {
    // Repository for api
    func getCities(city: String, success: @escaping (CitiesEntity) -> Void, error: @escaping () -> Void){
        
        let cityTrimming = city.trimmingCharacters(in: .whitespacesAndNewlines)
        let urlString = cityTrimming.replacingOccurrences(of: " ", with: "%20")
        Alamofire.request("https://www.metaweather.com/api/location/search/?query=\(urlString)", method: .get).responseArray { (response: DataResponse<[CityDTO]>) in
            
            var citiesToShow = CitiesEntity.init(cities: [])
            guard let citiesDto = response.value else {
                error()
                return
            }
            let cities = citiesDto.map {$0.toDomain()}
            citiesToShow.cities = cities
            success(citiesToShow)
        }
    }
    
    func getCityDetails(woeid: Int, success: @escaping (CityDetailsEntity) -> Void, error: @escaping () -> Void) {
        Alamofire.request("https://www.metaweather.com/api/location/\(woeid)/", method: .get).responseObject { (response: DataResponse<CityDetailsDTO>) in
            guard let cityDetailsToShow = response.value else {
                error()
                return
            }
            success(cityDetailsToShow.toDomain())
        }
    }
}
