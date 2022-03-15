//
//  ViewController.swift
//  WeatherSearcher
//
//  Created by Jose Alejandro Herrero on 3/14/22.
//

import UIKit
import Resolver
import SwiftUI
import Bond

class SearcherCitiesViewController: UIViewController {
    
    @Injected
    private var viewModel: SearcherCitiesViewModelProtocol
//    private let weatherRepository: DefaultWeatherRepository? = DefaultWeatherRepository()
    let rootStackView = UIStackView()
    
    var searchTab: SearchView = {
        let search = SearchView()
        return search
    }()
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
        viewModel.city.observeNext(with: {[weak self] cities in
            guard let cities = cities else {
                return }
            print(cities)
        })
        

        // Do any additional setup after loading the view.
//        weatherRepository?.getCities(success: { cities in
//            print(cities.cities?.count)
//        }, error: {
//            print("Error")
//        })
//        weatherRepository?.getCityDetails(woeid: 44418, success: { data in
//            print(data)
//        }, error: {
//            print("Error with CityDetail")
//        })
    }


}

extension SearcherCitiesViewController {
    
    func setup() {
//        searchTab.newText.observeNext {[weak self] text in
//            print(text)
//            self?.viewModel.searchCity(city: text ?? "")
//        }.dispose(in: bag)
        NotificationCenter.default.addObserver(self, selector: #selector(self.incomingNotification(_:)), name: NSNotification.Name(rawValue: "searchedText"), object: nil)
    }
    
    func style() {
        
        self.title = "Weather App"
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.axis = .vertical
        rootStackView.alignment = .trailing
        rootStackView.spacing = 10
    }
    func layout() {
        rootStackView.addArrangedSubview(searchTab)
        view.addSubview(rootStackView)
        
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            rootStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: rootStackView.trailingAnchor, multiplier: 0),
            searchTab.leadingAnchor.constraint(equalTo: rootStackView.leadingAnchor),
            searchTab.trailingAnchor.constraint(equalTo: rootStackView.trailingAnchor),
            searchTab.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    @objc func incomingNotification(_ notification: Notification) {
        if let text = notification.userInfo?["text"] as? String {
            viewModel.searchCity(city: text)
        }
    }
}

