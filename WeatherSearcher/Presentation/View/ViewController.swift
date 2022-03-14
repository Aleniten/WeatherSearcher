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
        weatherRepository?.create()
    }


}

