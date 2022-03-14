//
//  ViewController.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import UIKit

class ViewController: UIViewController {

    private let weatherRepository: DefaultWeatherRepository? = DefaultWeatherRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        weatherRepository?.getCities(success: { cities in
//            print(cities.cities?.count)
//        }, error: {
//            print("Error")
//        })
        weatherRepository?.getCityDetails(woeid: 44418, success: { data in
            print(data)
        }, error: {
            print("Error with CityDetail")
        })
    }


}

