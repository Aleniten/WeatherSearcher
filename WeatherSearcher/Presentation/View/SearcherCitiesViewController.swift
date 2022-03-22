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

class SearcherCitiesViewController: BaseViewController {
    // MARK: -  Injection of ViewModel
    @Injected
    private var viewModel: SearcherCitiesViewModelProtocol

    let rootStackView = UIStackView()
    // MARK: -  Programmatic views
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
    // MARK: -  Variable to populate for tableView
    var citiesArray = CitiesEntity.init(cities: [])
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
        getCitiesFromUserDefaults()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getCitiesFromUserDefaults()
        // Title dissapear because we empty in viewcycle willdisappear
        self.title = "Weather App"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // For clear navigation Title
        self.navigationItem.title = " "
        self.navigationController?.navigationBar.tintColor = Constants.Colors.whiteGray
    }


}
// MARK: - Extension of ViewController
extension SearcherCitiesViewController {
    // MARK: -  Function to get cities from data store
    func getCitiesFromUserDefaults() {
        self.showSpinner(self.view, self.spinner.isShowing)
        viewModel.getCities()
        self.tableView.reloadData()
        self.removeSpinner(0.5)
    }
    // MARK: -  delegates, Observers and Notifications
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.cities.observeNext(with: {[weak self] citiesBack in
            if let spinnerShowing = self?.spinner.isShowing, let superView = self?.view {
                self?.showSpinner(superView, spinnerShowing)
            }
            if let cities = citiesBack?.cities {
                if !cities.isEmpty {
                    self?.citiesArray = CitiesEntity.init(cities: cities)
                    self?.tableView.reloadData()
                    self?.removeSpinner(0.5)
                } else {
                    self?.viewModel.citySearched.observeNext(with: {[weak self] searched in
                        if let citySearched = searched {
                            self?.alertPresent(title: "Empty", "We couldn't find your city")
                        }
                    })
                    self?.getCitiesFromUserDefaults()
                }
            } else {
                self?.getCitiesFromUserDefaults()
                self?.viewModel.citySearched.observeNext(with: {[weak self] searched in
                    if let citySearched = searched {
                        self?.alertPresent(title: "Empty", "We couldn't find your city")
                    }
                })
            }
        }).dispose(in: bag)
        NotificationCenter.default.addObserver(self, selector: #selector(self.incomingNotification(_:)), name: NSNotification.Name(rawValue: "searchedText"), object: nil)
    }
    // MARK: -  Styles and configuration of views
    func style() {
        self.title = "Weather App"
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.axis = .vertical
        rootStackView.alignment = .trailing
        rootStackView.spacing = 10
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
    }
    // MARK: -  Layout of Views
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
// MARK: - Extension of TableView
extension SearcherCitiesViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: -  Delegates functions of TableView
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return citiesArray.cities?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitiesCell.identifier) as? CitiesCell else { return UITableViewCell() }
        cell.configureCell(cityName: citiesArray.cities?[indexPath.row].title, locationName: citiesArray.cities?[indexPath.row].locationType, favoriteState: citiesArray.cities?[indexPath.row].favorite)
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
