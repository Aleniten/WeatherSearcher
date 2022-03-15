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

    let rootStackView = UIStackView()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = Constants.Colors.backgroundGray
        table.register(CitiesCell.self, forCellReuseIdentifier: CitiesCell.identifier)
        return table
    }()
    
    var searchTab: SearchView = {
        let search = SearchView()
        return search
    }()
    
    var citiesArray = CitiesEntity.init(cities: [])
    
//    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
        viewModel.city.observeNext(with: {[weak self] cities in
            guard let cities = cities else {
                return }
            self?.citiesArray = cities
            self?.tableView.reloadData()
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
        tableView.dataSource = self
        tableView.delegate = self
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
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
    }
    func layout() {
        rootStackView.addArrangedSubview(searchTab)
//        rootStackView.addSubview(tableView)
        view.addSubview(rootStackView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            rootStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: rootStackView.trailingAnchor, multiplier: 0),
            searchTab.leadingAnchor.constraint(equalTo: rootStackView.leadingAnchor),
            searchTab.trailingAnchor.constraint(equalTo: rootStackView.trailingAnchor),
            searchTab.heightAnchor.constraint(equalToConstant: 56),
            rootStackView.heightAnchor.constraint(equalToConstant: 64),
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: rootStackView.bottomAnchor, multiplier: 0),
            tableView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: tableView.trailingAnchor, multiplier: 0),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 1),
        ])
    }
    
    @objc func incomingNotification(_ notification: Notification) {
        if let text = notification.userInfo?["text"] as? String {
            viewModel.searchCity(city: text)
        }
    }
}

extension SearcherCitiesViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return citiesArray.cities?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitiesCell.identifier) as? CitiesCell else { return UITableViewCell() }
        cell.configureCell(cityName: citiesArray.cities?[indexPath.row].title, cityLocation: citiesArray.cities?[indexPath.row].locationType, favoriteState: citiesArray.cities?[indexPath.row].favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TO DO
    }
    
    
}

