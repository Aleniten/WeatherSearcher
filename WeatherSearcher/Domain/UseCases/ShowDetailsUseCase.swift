//
//  ShowDetailsUseCase.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/15/22.
//

//import Foundation
//
//import Foundation
//import Resolver
//
//protocol ShowDetailsUseCaseProtocol {
//    func getCityDetailsToShow(woeid: City, success: @escaping (CityDetailsEntity) -> Void, error: @escaping () -> Void)
//}
//
//struct DefaultShowDetailsUseCase: ShowDetailsUseCaseProtocol {
//
//
//
//    @Injected
//    private var citiesRepository: CitiesRepositoryProtocols
//
//    func getCityDetails(woeid: Int, success: @escaping (CityDetailsEntity) -> Void, error: @escaping () -> Void) {
//        citiesRepository.getCityDetails(woeid: woeid, success: { cityDetail in
//            success(cityDetail)
//        }, error: {
//            print("Error in get City Details")
//        })
//    }
//}
