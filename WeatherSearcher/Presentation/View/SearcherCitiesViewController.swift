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
        getCitiesFromUserDefaults()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getCitiesFromUserDefaults()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // needed to clear the text in the back navigation:
        self.navigationItem.title = " "
        self.navigationController?.navigationBar.tintColor = Constants.Colors.whiteGray
    }


}

extension SearcherCitiesViewController {
    
    func getCitiesFromUserDefaults() {
        viewModel.getCities()
        self.tableView.reloadData()
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.cities.observeNext(with: {[weak self] cities in
            guard let cities = cities else { return }
            self?.citiesArray = cities
            self?.tableView.reloadData()
        }).dispose(in: bag)
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
        cell.configureCell(cityName: citiesArray.cities?[indexPath.row].title, favoriteState: citiesArray.cities?[indexPath.row].favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cityWOEID = citiesArray.cities?[indexPath.row].woeid else { return }
        let vc = CityDetailsViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.woeidToFill = cityWOEID

        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
}

